import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queen_validators/queen_validators.dart';
import '../../../helpers/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/styles/colors.dart';
import '../../../shared/constants.dart';
import '../../layouts/home_layout.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';
import '../sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is UserLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateAndFinish(context, const HomeLayout());
            });
          }
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateAndFinish(context, const HomeLayout());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BuildHeader(title: 'Login'),
                    sizedBox12,
                    const BuildSecondHeader(title: 'Add your details to login'),
                    sizedBox28,
                    DefaultTextFormField(
                      context: context,
                      hintText: 'Your Email',
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: qValidator([
                        const IsRequired(),
                        const IsEmail(),
                      ]),
                    ),
                    sizedBox15,
                    DefaultTextFormField(
                      context: context,
                      hintText: 'Password',
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                      validator: qValidator([
                        const IsRequired(),
                      ]),
                    ),
                    sizedBox15,
                    BuildCondition(
                      condition: state is! UserLoginLoadingsState,
                      builder: (context) => DefaultButton(
                        color: mainColor,
                        title: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    sizedBox15,
                    DefaultTextButton(
                      child: 'Forgot your Password?',
                      color: secondaryFontColor,
                      fontWeight: FontWeight.w400,
                      onPressed: () {},
                    ),
                    sizedBox28,
                    const BuildSecondHeader(title: 'Or Login With'),
                    sizedBox15,
                    RawButton(
                      buttonColor: Colors.blue,
                      image: 'assets/images/facebook.svg',
                      text: 'Login With Facebook',
                      onPressed: () {},
                    ),
                    sizedBox15,
                    BuildCondition(
                      condition: state is! CreateUserLoadingsState,
                      builder: (context) => RawButton(
                        buttonColor: Colors.red,
                        text: 'Login With Google',
                        image: 'assets/images/google.svg',
                        onPressed: () {
                          LoginCubit.get(context).logInWithGoogle();
                        },
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    sizedBox28,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BuildSecondHeader(
                            title: 'Don\'t have an Account?'),
                        DefaultTextButton(
                          child: 'Sign Up',
                          onPressed: () {
                            navigateTo(context, SignUp());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
