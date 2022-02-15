import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';
import 'cart_screen.dart';

class MealDetailScreen extends StatelessWidget {
  final String? mealId;
  final String? title;
  final dynamic price;
  final String? description;
  final String? image;
  final String? duration;
  final int? quantity;
  final bool? isFavorite;
  final bool? inCart;
  final String? category;

  const MealDetailScreen({
    Key? key,
    this.mealId,
    this.title,
    this.price,
    this.description,
    this.image,
    this.duration,
    this.quantity,
    this.isFavorite,
    this.inCart,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var cubit = AppCubit.get(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, CartScreen());
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('$image'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: size * 0.36),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTitle(title: '$title'),
                      CustomTitle(title: '\$ $price')
                    ],
                  ),
                  sizedBox20,
                  Row(
                    children: [
                      const Icon(Icons.timer),
                      Text('Cook In: $duration minutes'),
                    ],
                  ),
                  sizedBox20,
                  const Text('Description'),
                  sizedBox10,
                  BuildSecondHeader(title: '$description'),
                  const Spacer(),
                  BlocBuilder<AppCubit, AppStates>(
                    builder: (context, state) {
                      // if (state is ClearCart) {
                      //   AppCubit.get(context).updateCart(
                      //     mealId: mealId!,
                      //     inCart: false,
                      //     //inCart: inCart! ? false : inCart!,
                      //   );
                      // }

                      return BuildCondition(
                        condition: state is! AddProductLoadingState,
                        builder: (context) {
                          return cubit.cart.contains(mealId)
                              ? const Center(
                                  child: Text('In Cart!'),
                                )
                              : DefaultButton(
                                  title: 'Add to cart',
                                  onPressed: () {
                                    cubit.addProduct(
                                      productId: mealId!,
                                      title: title!,
                                      price: price,
                                      image: image!,
                                    );
                                  },
                                );
                        },
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              return Positioned(
                right: 20,
                top: size * 0.33,
                child: Card(
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        cubit.favorieProduct(mealId: mealId!);
                      },
                      icon: cubit.favorites[mealId]!
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
