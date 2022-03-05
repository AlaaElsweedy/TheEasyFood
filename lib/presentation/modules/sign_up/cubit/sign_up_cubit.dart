import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/user_model.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
  }) {
    emit(RegisterUserLoadingsState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
      );
    }).catchError((error) {
      emit(RegisterUserErrorState(error.toString()));
    });
  }

  void createUser({
    required String uId,
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    UserModel userModel = UserModel(
      uId: uId,
      name: name,
      email: email,
      address: address,
      phone: phone,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6Q82WISxpWPp5dHBTWHypFOZbRTvc0ST0xQ&usqp=CAU',
      bio: 'Write your bio...',
    );

    emit(CreateUserLoadingsState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error));
    });
  }
}
