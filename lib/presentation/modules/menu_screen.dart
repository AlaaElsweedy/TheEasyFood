import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 480,
            child: Stack(
              children: [
                Positioned(
                  width: 97,
                  height: 480,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Column(
                    children: [
                      buildMenuItem(title: 'Food', quantity: 120),
                      sizedBox10,
                      buildMenuItem(title: 'Beverages', quantity: 120),
                      sizedBox10,
                      buildMenuItem(title: 'Desserts', quantity: 120),
                      sizedBox10,
                      buildMenuItem(title: 'Promotions', quantity: 120),
                      sizedBox10,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildMenuItem({
  required String title,
  required int quantity,
}) =>
    SizedBox(
      width: 333,
      height: 87,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Container(
              width: 280,
              height: 87,
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildHeader(title: title),
                    BuildSecondHeader(
                      title: '$quantity Items',
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: Image.asset('assets/images/food.png'),
              ),
              Transform.translate(
                offset: const Offset(15, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const SizedBox(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.navigate_next,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
