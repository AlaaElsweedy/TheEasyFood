import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/data/models/cart_model.dart';
import 'package:talabat_app/data/models/category_model.dart';
import 'package:talabat_app/data/models/meal_model.dart';
import 'package:talabat_app/data/models/order_model.dart';
import 'package:talabat_app/data/models/restaurant_model.dart';
import 'package:talabat_app/data/models/user_model.dart';
import 'package:talabat_app/data/services/local/cache_helper.dart';
import 'package:talabat_app/presentation/modules/login/login_screen.dart';
import 'package:talabat_app/presentation/modules/menu_screen.dart';
import 'package:talabat_app/presentation/modules/more_screen.dart';
import 'package:talabat_app/presentation/modules/orders_screen.dart';
import 'package:talabat_app/presentation/modules/profile_screen.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final List<Widget> pages = [
    const MenuScreen(),
    const OrdersScreen(),
    ProfileScreen(),
    const MoreScreen(),
  ];

  void changeIndex(int index) {
    if (index == 2) {
      getUser();
    }

    if (index == 1) {
      getOrderProducts();
    }

    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  UserModel? userModel;
  void getUser() {
    emit(GetUserLoadingsState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

  void signOut(context) {
    CacheHelper.removeData('uId').then((value) {
      if (value) {
        FirebaseAuth.instance.signOut().then((value) {
          navigateAndFinish(context, LoginScreen());
        });
      }
    });
  }

  List<CategoryModel> categories = [];

  void getCategories() {
    emit(GetCategoryLoadingsState());

    FirebaseFirestore.instance.collection('categories').get().then((value) {
      for (var element in value.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }
      emit(GetCategorySuccessState());
    }).catchError((onError) {
      emit(GetCategoryErrorState(onError.toString()));
    });
  }

  List<MealModel> meals = [];
  Map<String, bool> favorites = {};
  List<String> cart = [];
  MealModel? mealModel;

  void getMeals() {
    meals = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meals')
        .get()
        .then((value) {
      for (var element in value.docs) {
        mealModel = MealModel.fromJson(element.data());
        meals.add(MealModel.fromJson(element.data()));
        favorites.addAll({element.id: mealModel!.isFavorite!});
        //cart.addAll({element.id});
      }
      emit(GetMealSuccessState());
    }).catchError((error) {
      emit(GetMealErrorState(error.toString()));
    });
  }

  List<RestaurantModel> restaurants = [];

  void getRestaurants() {
    FirebaseFirestore.instance.collection('restaurants').get().then((value) {
      for (var element in value.docs) {
        restaurants.add(RestaurantModel.fromJson(element.data()));
      }
      emit(GetRestaurentsSuccessState());
    }).catchError((error) {
      emit(GetRestaurentsErrorState(error.toString()));
    });
  }

  void updateProfile({
    required String? name,
    required String? address,
    required String? phone,
    String? image,
    String? bio,
  }) {
    emit(UpdateProfileLoadingsState());

    UserModel model = UserModel(
      uId: userModel!.uId,
      name: name,
      email: userModel!.email,
      address: address,
      phone: phone,
      image: image ?? userModel!.image,
      bio: bio ?? userModel!.bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      emit(UpdateProfileErrorState(error.toString()));
    });
  }

  File? image;
  var picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ProfileImageSuccessState());
    } else {
      emit(ProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(UploadProfileImageLoadingsState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProfile(
          name: name,
          address: address,
          phone: phone,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  List<CartModel> cartList = [];

  void addProduct({
    required String title,
    required String productId,
    required String image,
    required dynamic price,
  }) {
    emit(AddProductLoadingState());

    CartModel cartModel = CartModel(
      title: title,
      image: image,
      price: price,
      mealId: productId,
      quantity: 1,
    );

    cart.add(productId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(productId)
        .set(cartModel.toJson())
        .then((value) {
      getCartProducts();
    }).catchError((error) {
      emit(AddProductErrorState());
    });
  }

  // void updateCart({
  //   required String mealId,
  //   required bool inCart,
  // }) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .collection('meals')
  //       .doc(mealId)
  //       .update({'inCart': inCart}).then((value) {
  //     getMeals();
  //   }).catchError((error) {
  //     emit(UpdateProductErrorState());
  //   });
  // }

  void getCartProducts() {
    cartList = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .get()
        .then((value) {
      for (var element in value.docs) {
        cartList.add(CartModel.fromJson(element.data()));
      }
      emit(GetProductSuccessState());
    }).catchError((error) {
      emit(GetProductErrorState(error.toString()));
    });
  }

  void clearCart() async {
    cartList.clear();

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    // updateCart(
    //   mealId: mealId,
    //   inCart: false,
    // );
    emit(ClearCart());
  }

  void favorieProduct({
    required String mealId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('meals')
        .doc(mealId)
        .update({'isFavorite': !favorites[mealId]!}).then((value) {
      getMeals();
    }).catchError((error) {
      emit(FavoriteProductErrorState(error.toString()));
    });
  }

  get getTotal {
    dynamic total = 0.0;
    for (var element in cartList) {
      total += element.price * element.quantity;
    }
    return total;
  }

  removeItem(String productId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(productId)
        .delete()
        .then((value) {
      //updateCart(mealId: productId, inCart: false);
      getCartProducts();
    });
  }

  void addOrder({
    required dynamic total,
    required List<CartModel> cartItem,
  }) {
    String autoGenerateFirebaseId = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orders')
        .doc()
        .id;

    OrderModel model = OrderModel(
      id: autoGenerateFirebaseId,
      dateTime: DateFormat.yMMMd().add_jm().format(DateTime.now()),
      total: total,
      cartItem: cartItem,
    );

    cart.clear();
    //getMeals();

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orders')
        .add(model.toJson())
        .then((value) {
      getOrderProducts();

      clearCart();
    }).catchError((error) {
      emit(AddOrderctErrorState(error.toString()));
    });
  }

  List<OrderModel> orders = [];
  void getOrderProducts() {
    //orders = [];

    if (orders.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('orders')
          .get()
          .then((value) {
        for (var element in value.docs) {
          orders.add(OrderModel.fromJson(element.data()));
        }
        emit(GetOrdersSuccessState());
      }).catchError((error) {
        emit(GetOrdersErrorState());
      });
    }
  }

  get deliveryCost {
    double total = getTotalOrdersPrice * 0.04;
    String inString = total.toStringAsFixed(2);
    double inDouble = double.parse(inString);
    return inDouble;
  }

  get getTotalOrdersPrice {
    double total = 0.0;
    for (var item in orders) {
      total += item.total;
    }
    return total;
  }

  void clearOrders() async {
    orders.clear();

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orders');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(ClearOrders());
    emit(GetOrdersSuccessState());
  }
}
