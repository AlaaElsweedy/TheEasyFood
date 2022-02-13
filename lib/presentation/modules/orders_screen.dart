import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/data/models/cart_model.dart';
import 'package:talabat_app/data/models/order_model.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/components/styles/colors.dart';
import 'package:talabat_app/shared/constants.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Order')),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          var orders = AppCubit.get(context).orders;

          return BuildCondition(
            condition: orders.isNotEmpty,
            builder: (context) => Padding(
              padding: paddingAll,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: orders.length,
                      itemBuilder: (context, index) => _BuildOrderListItem(
                        order: orders[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 2,
                      ),
                    ),
                  ),
                  sizedBox20,
                  DefaultButton(title: 'Checkout', onPressed: () {}),
                ],
              ),
            ),
            fallback: (context) => const CircularIndicator(),
          );
        },
      ),
    );
  }
}

class _BuildOrderListItem extends StatelessWidget {
  final OrderModel order;

  const _BuildOrderListItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Time'),
                Text(
                  order.dateTime,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            sizedBox12,
            Container(
              padding: const EdgeInsets.all(8),
              color: textFieldColor,
              child: ListView(
                shrinkWrap: true,
                children: order.cartItem
                    .map(
                      (prod) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${prod.title} x${prod.quantity}',
                              ),
                              Text(
                                '\$${prod.price}',
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            sizedBox10,
            TotalText(title: 'Total', price: order.total.toString())
          ],
        ),
      ),
    );
  }
}
