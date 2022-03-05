import 'package:flutter/material.dart';
import '../../data/models/meal_model.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';

class CategoryScreen extends StatelessWidget {
  final String? categoryName;
  final List<MealModel> meals;

  const CategoryScreen({
    Key? key,
    required this.categoryName,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 320,
                ),
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 164,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                            height: 240,
                            width: 164,
                            child: Image.network(
                              meals[index].image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          sizedBox10,
                          CustomText(
                            text: meals[index].title!,
                            fontSize: 16,
                          ),
                          CustomText(
                            text: '\$${meals[index].price}',
                            fontSize: 16,
                            color: mainColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Alignment alignment;
  final int? maxLines;
  final double? height;

  const CustomText({
    Key? key,
    this.text = '',
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLines,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
