import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talabat_app/data/models/order_history_model.dart';
import 'states.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/meal_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/restaurant_model.dart';
import '../../data/models/user_model.dart';
import '../../helpers/cache_helper.dart';
import '../../presentation/modules/login/login_screen.dart';
import '../../presentation/modules/menu_screen.dart';
import '../../presentation/modules/more_screen.dart';
import '../../presentation/modules/orders_screen.dart';
import '../../presentation/modules/profile_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';

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

  //* get user and signout
  UserModel? userModel;
  void getUser() {
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

//* change user profile
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

  //* get categories and restaurants
  List<CategoryModel> categories = [];

  void getCategories() {
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      for (var element in value.docs) {
        categories.add(CategoryModel.fromJson(element.data()));
      }
      emit(GetCategorySuccessState());
    }).catchError((onError) {
      emit(GetCategoryErrorState(onError.toString()));
    });
  }

  List<RestaurantModel> restaurants = [];

  void getRestaurants() {
    FirebaseFirestore.instance.collection('restaurants').get().then((value) {
      for (var element in value.docs) {
        restaurants.add(RestaurantModel.fromJson(element.data()));
      }
      emit(GetRestaurantsSuccessState());
    }).catchError((error) {
      emit(GetRestaurantsErrorState(error.toString()));
    });
  }

//* get meals
  List<MealModel> meals = [];

  void getMeals() {
    meals = [];

    FirebaseFirestore.instance.collection('meals').get().then((value) {
      for (var element in value.docs) {
        meals.add(MealModel.fromJson(element.data()));
      }
      emit(GetMealSuccessState());
    }).catchError((error) {
      emit(GetMealErrorState(error.toString()));
    });
  }
//* ------------------ End Of Meals Screen ---------------- //

//* Cart Screen
  List<CartModel> cartProducts = [];
  List<String> cart = [];

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

    //cart.add(productId);

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

  void getCartProducts() {
    cartProducts = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .get()
        .then((value) {
      for (var element in value.docs) {
        cartProducts.add(CartModel.fromJson(element.data()));
        cart.add(element.id);
      }
      emit(GetProductSuccessState());
    }).catchError((error) {
      emit(GetProductErrorState(error.toString()));
    });
  }

  void clearCart() async {
    cartProducts.clear();

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(ClearCart());
  }

  removeItem(String productId) {
    cart.remove(productId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .doc(productId)
        .delete()
        .then((value) {
      getCartProducts();
    });
  }

  get getTotal {
    dynamic total = 0.0;
    for (var element in cartProducts) {
      total += element.price * element.quantity;
    }
    return total;
  }

//* ------------------ End Of Cart Screen ---------------- //

//* Order Screen
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

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orders')
        .add(model.toJson())
        .then((value) {
      getOrderProducts();
      clearCart();
    }).catchError((error) {
      emit(AddOrdersErrorState(error.toString()));
    });
  }

  List<OrderModel> orders = [];
  void getOrderProducts() {
    orders = [];
    emit(GetOrdersLoadingState());

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

  get deliveryCost {
    double total = getSubTotalOrdersPrice * 0.1;
    String inString = total.toStringAsFixed(2);
    double inDouble = double.parse(inString);
    return inDouble;
  }

  get getSubTotalOrdersPrice {
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

//* ------------------ End Of Order Screen ---------------- //

  List<String> favorites = [];
  List<FavoriteModel> favoriteProducts = [];

  void changeFavoriteProductState({
    required String productId,
    required String title,
    required String image,
    required dynamic price,
  }) {
    FavoriteModel model = FavoriteModel(
      productId: productId,
      title: title,
      image: image,
      price: price,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorites')
        .doc(productId)
        .set(model.toMap())
        .then((value) {
      getFavorites();
    }).catchError((error) {
      emit(FavoriteProductErrorState(error.toString()));
    });
  }

  void getFavorites() {
    favoriteProducts = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorites')
        .get()
        .then((value) {
      for (var element in value.docs) {
        favoriteProducts.add(FavoriteModel.fromJson(element.data()));
        favorites.add(element.id);
      }
      emit(GetFavoriteProductsSuccessState());
    }).catchError((error) {
      emit(GetFavoriteProductsErrorState());
    });
  }

  removeFavoriteProduct(String productId) {
    favorites.remove(productId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorites')
        .doc(productId)
        .delete()
        .then((value) {
      getFavorites();
    });
  }

  void addOrdersHistory({
    required dynamic totalPrice,
    required String address,
  }) {
    OrderHistoryModel model = OrderHistoryModel(
      totalPrice: totalPrice,
      dateTime: DateFormat.yMMMd().add_jm().format(DateTime.now()),
      address: address,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orderHistory')
        .add(model.toMap())
        .then((value) {
      getOrdersHistory();
    }).catchError((error) {
      emit(AddOrdersHistoryErrorState());
    });
  }

  List<OrderHistoryModel> ordersHistory = [];
  void getOrdersHistory() {
    ordersHistory = [];

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('orderHistory')
        .get()
        .then((value) {
      for (var element in value.docs) {
        ordersHistory.add(OrderHistoryModel.fromJson(element.data()));
      }
      emit(GetOrdersHistorySuccessState());
    }).catchError((error) {
      emit(GetOrdersHistoryErrorState());
    });
  }
}
