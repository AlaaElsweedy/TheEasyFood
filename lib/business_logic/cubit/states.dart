abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavBarState extends AppStates {}

class SignOut extends AppStates {}

//Get User
class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {
  final String error;

  GetUserErrorState(this.error);
}

//Get Category
class GetCategorySuccessState extends AppStates {}

class GetCategoryErrorState extends AppStates {
  final String error;

  GetCategoryErrorState(this.error);
}

// get restaurants
class GetRestaurantsSuccessState extends AppStates {}

class GetRestaurantsErrorState extends AppStates {
  final String error;

  GetRestaurantsErrorState(this.error);
}

//get meal
class GetMealSuccessState extends AppStates {}

class GetMealErrorState extends AppStates {
  final String error;

  GetMealErrorState(this.error);
}

class FavoriteProductSuccessState extends AppStates {}

class FavoriteProductErrorState extends AppStates {
  final String error;

  FavoriteProductErrorState(this.error);
}

class GetFavoriteProductsSuccessState extends AppStates {}

class GetFavoriteProductsErrorState extends AppStates {}

// profile image
class UpdateProfileLoadingsState extends AppStates {}

class UpdateProfileSuccessState extends AppStates {}

class UpdateProfileErrorState extends AppStates {
  final String error;

  UpdateProfileErrorState(this.error);
}

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

class ClearCart extends AppStates {}

class Increment extends AppStates {}

class Decrement extends AppStates {}

// orders
class AddOrdersErrorState extends AppStates {
  final String error;

  AddOrdersErrorState(this.error);
}

class GetOrdersSuccessState extends AppStates {}

class GetOrdersLoadingState extends AppStates {}

class GetOrdersErrorState extends AppStates {}

class ClearOrders extends AppStates {}

class AddOrdersHistoryErrorState extends AppStates {}

class GetOrdersHistoryErrorState extends AppStates {}

class GetOrdersHistorySuccessState extends AppStates {}
