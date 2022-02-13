abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

//User Login
class UserLoginLoadingsState extends LoginStates {}

class UserLoginSuccessState extends LoginStates {
  final String uId;

  UserLoginSuccessState(this.uId);
}

class UserLoginErrorState extends LoginStates {
  final String error;

  UserLoginErrorState(this.error);
}

//Google logIn
class SignInGoogleLoadingsState extends LoginStates {}

class SignInGoogleSuccessState extends LoginStates {}

class SignInGoogleErrorState extends LoginStates {
  final String error;

  SignInGoogleErrorState(this.error);
}

class CreateUserLoadingsState extends LoginStates {}

class CreateUserSuccessState extends LoginStates {
  final String uId;

  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends LoginStates {
  final String error;

  CreateUserErrorState(this.error);
}
