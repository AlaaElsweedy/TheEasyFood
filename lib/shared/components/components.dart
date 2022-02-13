import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talabat_app/data/models/place_suggestation_model.dart';
import 'package:talabat_app/presentation/modules/cart_screen.dart';
import 'styles/colors.dart';

class DefaultTextFormField extends StatelessWidget {
  final BuildContext context;
  final String hintText;
  final String? Function(String? val)? validator;
  final TextEditingController controller;
  final TextInputType type;
  final bool isPassword;
  const DefaultTextFormField({
    Key? key,
    required this.context,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.type,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: textFieldColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: textFieldColor,
          ),
        ),
        filled: true,
        fillColor: textFieldColor,
        contentPadding: const EdgeInsets.only(left: 34, top: 40),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class BuildHeader extends StatelessWidget {
  final String title;

  const BuildHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: primaryFontColor,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

class TotalText extends StatelessWidget {
  final String title;
  final String price;

  const TotalText({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: mainColor),
        ),
        Text(
          '\$$price',
          style: const TextStyle(color: mainColor),
        ),
      ],
    );
  }
}

Widget buildSecondHeader({
  required var title,
  double? fontSize,
  TextAlign? textAlign,
}) =>
    Text(
      title,
      textAlign: textAlign,
      style: TextStyle(color: secondaryFontColor, fontSize: fontSize),
    );

Widget customTitle({
  required var title,
  double? fontSize = 18.0,
}) =>
    Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );

class DefaultButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  final Color textColor;
  final double width;
  final double height;

  const DefaultButton({
    Key? key,
    this.color = mainColor,
    required this.title,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 56,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(title),
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      height: height,
      minWidth: width,
    );
  }
}

Widget rawButton({
  required Color buttonColor,
  required String text,
  required String image,
  required VoidCallback onPressed,
}) {
  return MaterialButton(
    color: buttonColor,
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    height: 56,
    minWidth: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 32.4),
        Text(text),
      ],
    ),
    onPressed: onPressed,
  );
}

class DefaultTextButton extends StatelessWidget {
  final Color? color;
  final String child;
  final VoidCallback onPressed;
  final FontWeight fontWeight;

  const DefaultTextButton({
    Key? key,
    this.color,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        child,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final double? elevation;
  final Color? iconColor;
  final BuildContext context;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.elevation,
    this.iconColor,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            navigateTo(context, const CartScreen());
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 280,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
        ],
      ),
    );
  }
}

class PlaceItem extends StatelessWidget {
  final PlaceSuggestion suggestion;

  const PlaceItem({Key? key, required this.suggestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestion.description
        .replaceAll(suggestion.description.split(',')[0], '');
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor[200],
              ),
              child: const Icon(
                Icons.place,
                color: mainColor,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${suggestion.description.split(',')[0]}\n',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: subTitle.substring(2),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

Widget buildDrawerHeader(context) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.orange[100],
        ),
        child: Image.asset(
          'assets/images/image.jpg',
          fit: BoxFit.cover,
        ),
      ),
      const Text(
        'Alaa Shoukri',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget buildDrawerListItem(
    {required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color}) {
  return ListTile(
    leading: Icon(
      leadingIcon,
      color: color ?? mainColor,
    ),
    title: Text(title),
    trailing: trailing ??= const Icon(
      Icons.arrow_right,
      color: mainColor,
    ),
    onTap: onTap,
  );
}

Widget buildDrawerListItemsDivider() {
  return const Divider(
    height: 0,
    thickness: 1,
    indent: 18,
    endIndent: 24,
  );
}
