import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/data/models/order_history_model.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';

class OrderHistory extends StatelessWidget {
  final String? address;
  final DateTime? dateTime;
  final double? totalBilled;

  const OrderHistory({
    Key? key,
    this.address,
    this.dateTime,
    this.totalBilled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        var orders = AppCubit.get(context).ordersHistory;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Order History'),
          ),
          body: Padding(
            padding: paddingAll,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        orderHistoryItem(orders[index]),
                    separatorBuilder: (context, index) => sizedBox15,
                    itemCount: orders.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget orderHistoryItem(OrderHistoryModel model) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.dateTime,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Pending',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            sizedBox10,
            const MyDivider(),
            SizedBox(
              width: 100,
              child: Text(
                model.address,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const MyDivider(),
            sizedBox10,
            TotalText(
              title: 'Total Billed',
              price: model.totalPrice.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
