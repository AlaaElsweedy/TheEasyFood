abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavBarState extends AppStates {}

class SignOut extends AppStates {}

//Get User
class GetUserLoadingsState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

//Get Gategory
class GetCategoryLoadingsState extends AppStates {}

class GetCategorySuccessState extends AppStates {}

class GetCategoryErrorState extends AppStates {
  final String error;

  GetCategoryErrorState(this.error);
}

//get meal
class GetMealLoadingsState extends AppStates {}

class GetMealSuccessState extends AppStates {}

class GetMealErrorState extends AppStates {
  final String error;

  GetMealErrorState(this.error);
}

// get restaurents
class GetRestaurentsSuccessState extends AppStates {}

class GetRestaurentsErrorState extends AppStates {
  final String error;

  GetRestaurentsErrorState(this.error);
}

class UpdateProfileLoadingsState extends AppStates {}

class UpdateProfileSuccessState extends AppStates {}

class UpdateProfileErrorState extends AppStates {
  final String error;

  UpdateProfileErrorState(this.error);
}

// profile image
class ProfileImageSuccessState extends AppStates {}

class ProfileImageErrorState extends AppStates {}

class UploadProfileImageLoadingsState extends AppStates {}

class UploadProfileImageErrorState extends AppStates {}

// add product
class AddProductLoadingState extends AppStates {}

class AddProductSuccessState extends AppStates {}

class AddProductErrorState extends AppStates {}

// get product
class GetProductLoadingState extends AppStates {}

class GetProductSuccessState extends AppStates {}

class GetProductErrorState extends AppStates {
  final String error;

  GetProductErrorState(this.error);
}

class UpdateProductErrorState extends AppStates {}

class FavoriteProductSuccessState extends AppStates {}

class FavoriteProductErrorState extends AppStates {
  final String error;

  FavoriteProductErrorState(this.error);
}

class Increment extends AppStates {}

class Decrement extends AppStates {}

class AddOrderctErrorState extends AppStates {
  final String error;

  AddOrderctErrorState(this.error);
}

class GetOrdersSuccessState extends AppStates {}

class GetOrdersErrorState extends AppStates {}

class ClearCart extends AppStates {}
