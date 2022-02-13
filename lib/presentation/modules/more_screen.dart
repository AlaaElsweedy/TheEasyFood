import 'package:flutter/material.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/components/styles/colors.dart';
import 'package:talabat_app/shared/constants.dart';
import 'about_us.dart';
import 'address_screen.dart';

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
              const BuildItem(title: 'Payment Details'),
              sizedBox15,
              const BuildItem(title: 'My Orders'),
              sizedBox15,
              InkWell(
                onTap: () => navigateTo(context, const AddressScreen()),
                child: const BuildItem(title: 'Addresses'),
              ),
              sizedBox15,
              const BuildItem(title: 'Notification'),
              sizedBox15,
              InkWell(
                  onTap: () => navigateTo(context, const AboutUs()),
                  child: const BuildItem(title: 'About Us')),
            ],
          )),
    );
  }
}

class BuildItem extends StatelessWidget {
  static const Color itemColor = Color(0xffF6F6F6);
  final String title;

  const BuildItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
      ],
    );
  }
}
