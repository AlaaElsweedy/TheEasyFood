abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

//User register
class RegisterUserLoadingsState extends SignUpStates {}

class RegisterUserSuccessState extends SignUpStates {}

class RegisterUserErrorState extends SignUpStates {
  final String error;

  RegisterUserErrorState(this.error);
}

//Create user
class CreateUserLoadingsState extends SignUpStates {}

class CreateUserSuccessState extends SignUpStates {}

class CreateUserErrorState extends SignUpStates {
  final String error;

  CreateUserErrorState(this.error);
}
