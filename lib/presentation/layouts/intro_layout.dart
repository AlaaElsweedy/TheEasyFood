import 'package:flutter/material.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';
import '../modules/login/login_screen.dart';
import '../modules/sign_up/sign_up_screen.dart';

class IntroLayout extends StatelessWidget {
  const IntroLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              'assets/images/orange_shape.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TALABAT',
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 6),
                const BuildSecondHeader(title: 'FOOD DELIVERY'),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DefaultButton(
                    color: mainColor,
                    title: 'Login',
                    onPressed: () {
                      navigateTo(context, LoginScreen());
                    },
                  ),
                ),
                sizedBox15,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    child: const Text('Create an Account'),
                    textColor: mainColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: mainColor),
                    ),
                    onPressed: () {
                      navigateTo(context, SignUp());
                    },
                    height: 56,
                    minWidth: double.infinity,
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
