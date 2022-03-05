import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/presentation/modules/checkout_screen.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../data/models/order_model.dart';
import 'home_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        var orders = AppCubit.get(context).orders;
        var cubit = AppCubit.get(context);

        double subTotal = cubit.getSubTotalOrdersPrice;
        double deliveryCost = cubit.deliveryCost;
        double total = subTotal + deliveryCost;

        if (state is! GetOrdersSuccessState) {
          return const CircularIndicator();
        }

        return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Order'),
                  orders.isEmpty
                      ? Container()
                      : InkWell(
                          onTap: () => cubit.clearOrders(),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            body: BuildCondition(
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
                    sizedBox15,
                    TotalDeliveryPrice(
                      title: 'Sub Total',
                      price: subTotal,
                      fontSize: 15,
                    ),
                    sizedBox15,
                    TotalDeliveryPrice(
                      title: 'Delivery Cost',
                      price: deliveryCost,
                      fontSize: 15,
                    ),
                    sizedBox15,
                    TotalDeliveryPrice(
                      title: 'Total',
                      price: total,
                    ),
                    sizedBox20,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: DefaultButton(
                        title: 'Checkout',
                        onPressed: () {
                          navigateTo(
                            context,
                            CheckoutScreen(
                              deliveryCost: deliveryCost,
                              subTotal: subTotal,
                              total: total,
                            ),
                          );
                          cubit.clearOrders();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/no_orders.gif'),
                    sizedBox10,
                    DefaultButton(
                      title: 'Go Shopping',
                      width: 150,
                      onPressed: () {
                        navigateTo(context, const HomeScreen());
                      },
                    ),
                  ],
                ),
              ),
            ));
      },
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
            sizedBox10,
            Container(
              padding: const EdgeInsets.all(8),
              color: textFieldColor,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
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
