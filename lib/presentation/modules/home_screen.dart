import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/data/models/category_model.dart';
import 'package:talabat_app/data/models/meal_model.dart';
import 'package:talabat_app/data/models/restaurant_model.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';
import 'category_screen.dart';
import 'meal_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var meals = AppCubit.get(context).meals;
        var restaurant = AppCubit.get(context).restaurants;
        var category = AppCubit.get(context).categories;

        return BuildCondition(
          condition: category.isNotEmpty,
          builder: (context) => Scaffold(
            appBar: DefaultAppBar(
              title: 'Good Morning',
              context: context,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: paddingAll,
                    child: SizedBox(
                      height: 120,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => navigateTo(
                                context,
                                CategoryScreen(
                                  categoryName: category[index].name,
                                  meals: meals
                                      .where((product) =>
                                          product.category ==
                                          category[index].name!.toLowerCase())
                                      .toList(),
                                )),
                            child: CategoryItem(
                              category: category[index],
                              //meal: meal[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: paddingHorizontal,
                    child: ViewAllWidget('Popular Restaurant'),
                  ),

                  // popular restaurant list
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => PopularRestaurantItem(
                        restaurentModel: restaurant[index],
                      ),
                      separatorBuilder: (context, index) => sizedBox20,
                      itemCount: restaurant.length,
                    ),
                  ),
                  sizedBox20,
                  const Padding(
                    padding: paddingHorizontal,
                    child: ViewAllWidget('Most Popular'),
                  ),

                  // most popular list
                  SizedBox(
                    height: 180,
                    child: Padding(
                      padding: paddingAll,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => MostPopular(
                          mealModel: meals[index],
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: meals.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

class PopularRestaurantItem extends StatelessWidget {
  final RestaurantModel? restaurentModel;
  const PopularRestaurantItem({
    this.restaurentModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(restaurentModel!.image!),
            ),
          ),
        ),
        sizedBox10,
        Padding(
          padding: paddingHorizontal,
          child: customTitle(title: '${restaurentModel!.name}'),
        ),
      ],
    );
  }
}

class MostPopular extends StatelessWidget {
  final MealModel? mealModel;

  const MostPopular({
    this.mealModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => navigateTo(
              context,
              MealDetailScreen(
                mealId: mealModel!.mealId,
                title: mealModel!.title,
                price: mealModel!.price,
                description: mealModel!.description,
                image: mealModel!.image,
                duration: mealModel!.duration,
                isFavorite: mealModel!.isFavorite,
                inCart: mealModel!.inCart,
                category: mealModel!.category,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(mealModel!.image!),
                  ),
                ),
              ),
              sizedBox10,
              Padding(
                padding: paddingHorizontal,
                child: customTitle(title: '${mealModel!.title}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ViewAllWidget extends StatelessWidget {
  final String title;
  const ViewAllWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        DefaultTextButton(
          child: 'View All',
          onPressed: () {},
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  //final MealModel meal;

  const CategoryItem({
    Key? key,
    required this.category,
    //required this.meal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage('${category.image}'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 8),
        customTitle(
          title: '${category.name}',
          fontSize: 15,
        )
      ],
    );
  }
}
