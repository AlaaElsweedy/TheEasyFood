import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/presentation/modules/home_screen.dart';
import 'package:talabat_app/presentation/modules/map_screen.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/components/styles/colors.dart';
import 'package:talabat_app/shared/constants.dart';

// ignore: must_be_immutable
class CheckoutScreen extends StatefulWidget {
  String? currentPosition;
  final dynamic subTotal;
  final dynamic deliveryCost;
  final dynamic total;

  CheckoutScreen({
    Key? key,
    this.currentPosition,
    this.subTotal,
    this.deliveryCost,
    this.total,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

enum PaymentMethods { cash }

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedValue = 1;
  PaymentMethods paymentMethods = PaymentMethods.cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFieldColor,
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Container(
            color: backgroundColor,
            width: double.infinity,
            child: Padding(
              padding: paddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Address',
                    style: TextStyle(
                      color: secondaryFontColor,
                    ),
                  ),
                  sizedBox15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          widget.currentPosition ?? 'Change your address..',
                          maxLines: 2,
                        ),
                      ),
                      DefaultTextButton(
                        onPressed: () async {
                          widget.currentPosition = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MapScreen(),
                            ),
                          );
                          setState(() {});
                        },
                        child: 'Change',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sizedBox10,
          Container(
            color: backgroundColor,
            child: Padding(
              padding: paddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment method'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cash on delivery'),
                      SizedBox(
                        width: 80,
                        child: RadioListTile<PaymentMethods>(
                          value: PaymentMethods.cash,
                          groupValue: paymentMethods,
                          onChanged: (PaymentMethods? value) => setState(() {
                            paymentMethods = value!;
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sizedBox10,
          Container(
            padding: paddingAll,
            color: backgroundColor,
            child: Column(
              children: [
                TotalDeliveryPrice(
                  price: widget.subTotal,
                  title: 'Sub Total',
                  fontSize: 15,
                ),
                sizedBox10,
                TotalDeliveryPrice(
                  price: widget.deliveryCost,
                  title: 'Delivery Cost',
                  fontSize: 15,
                ),
                sizedBox10,
                TotalDeliveryPrice(
                  price: widget.total,
                  title: 'Total',
                  fontSize: 15,
                ),
              ],
            ),
          ),
          sizedBox10,
          Container(
            color: backgroundColor,
            child: Padding(
              padding: paddingAll,
              child: BlocBuilder<AppCubit, AppStates>(
                builder: (context, state) {
                  return DefaultButton(
                    title: 'Send Order',
                    onPressed: () {
                      AppCubit.get(context).addOrdersHistory(
                        totalPrice: widget.total,
                        address: widget.currentPosition!,
                      );
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        context: context,
                        builder: (context) => SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: paddingAll,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/order_done.png',
                                  height: 200,
                                ),
                                sizedBox10,
                                const Text(
                                  'Thank You!',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBox20,
                                const Text(
                                  'Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order',
                                  textAlign: TextAlign.center,
                                ),
                                sizedBox20,
                                DefaultTextButton(
                                  onPressed: () {
                                    navigateTo(context, const HomeScreen());
                                  },
                                  child: 'Back To Home',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
