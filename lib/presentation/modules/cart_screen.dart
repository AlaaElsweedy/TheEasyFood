import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../data/models/cart_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var totalPrice = cubit.getTotal;
        var cart = AppCubit.get(context).cartProducts;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: textFieldColor,
            title: const Text('Cart'),
          ),
          backgroundColor: textFieldColor,
          body: Padding(
            padding: paddingAll,
            child: BuildCondition(
              condition: cart.isNotEmpty,
              builder: (context) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return BuildItem(model: cart[index]);
                        },
                        separatorBuilder: (context, index) => sizedBox10,
                        itemCount: cart.length,
                      ),
                    ),
                    sizedBox15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(color: mainColor),
                        ),
                        Text(
                          '$totalPrice',
                          style: const TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                    sizedBox15,
                    DefaultButton(
                      title: 'Checkout',
                      onPressed: () {
                        cubit.addOrder(
                          cartItem: cart,
                          total: totalPrice,
                        );
                        cubit.getOrderProducts();
                      },
                    ),
                  ],
                );
              },
              fallback: (context) =>
                  Center(child: Image.asset('assets/images/empty_cart.png')),
            ),
          ),
        );
      },
    );
  }
}

class BuildItem extends StatelessWidget {
  final CartModel? model;

  const BuildItem({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(model!.mealId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      onDismissed: (direction) =>
          AppCubit.get(context).removeItem(model!.mealId),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    model!.image,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      model!.title,
                    ),
                  ),
                  sizedBox10,
                  Text('\$${model!.price}'),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  RoundedButton(
                    title: '-',
                    onPressed: () {},
                  ),
                  Text('${model!.quantity}'),
                  RoundedButton(
                    title: '+',
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const RoundedButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(title),
      minWidth: 30,
      height: 25,
      color: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
