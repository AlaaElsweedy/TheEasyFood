import 'package:flutter/material.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/presentation/modules/order_history_screen.dart';
import 'package:talabat_app/presentation/modules/wishlist_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';
import 'about_us.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(context: context, title: 'More'),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              BuildItem(title: 'Payment Details'),
              sizedBox15,
              BuildItem(
                title: 'Order History',
                onPressed: () {
                  AppCubit.get(context).getFavorites();
                  navigateTo(context, const OrderHistory());
                },
              ),
              sizedBox15,
              BuildItem(
                title: 'Wish List',
                onPressed: () {
                  AppCubit.get(context).getFavorites();
                  navigateTo(context, const WhishListScreen());
                },
              ),
              sizedBox15,
              BuildItem(title: 'Notification'),
              sizedBox15,
              BuildItem(
                title: 'About Us',
                onPressed: () => navigateTo(context, const AboutUs()),
              ),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class BuildItem extends StatelessWidget {
  static const Color itemColor = Color(0xffF6F6F6);
  final String title;
  VoidCallback? onPressed;

  BuildItem({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: const BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: placeHolderColor,
                    radius: 25,
                    child: Icon(
                      Icons.mail,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: const TextStyle(color: primaryFontColor),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 22,
              ),
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
