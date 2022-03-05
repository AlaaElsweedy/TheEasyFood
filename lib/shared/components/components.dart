import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/map/place_directions_model.dart';
import '../../data/models/map/place_suggestion_model.dart';
import '../../presentation/modules/cart_screen.dart';
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
          borderSide: const BorderSide(
            color: textFieldColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
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

class TotalDeliveryPrice extends StatelessWidget {
  final double price;
  final String title;
  final double fontSize;

  const TotalDeliveryPrice({
    Key? key,
    required this.price,
    required this.title,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          '\$$price',
          style: TextStyle(
            color: mainColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BuildSecondHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextAlign? textAlign;

  const BuildSecondHeader({
    Key? key,
    required this.title,
    this.fontSize,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(color: secondaryFontColor, fontSize: fontSize),
    );
  }
}

class CustomTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const CustomTitle({
    Key? key,
    required this.title,
    this.fontSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

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

class RawButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final String image;
  final VoidCallback onPressed;

  const RawButton({
    Key? key,
    required this.buttonColor,
    required this.text,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const BuildDrawerHeader(),
            ),
          ),
          const BuildDrawerListItem(
            leadingIcon: Icons.person,
            title: 'My Profile',
          ),
          const BuildDrawerListItemsDivider(),
          BuildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          const BuildDrawerListItemsDivider(),
          const BuildDrawerListItem(
            leadingIcon: Icons.settings,
            title: 'Settings',
          ),
          const BuildDrawerListItemsDivider(),
          const BuildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          const BuildDrawerListItemsDivider(),
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

class BuildDrawerHeader extends StatelessWidget {
  const BuildDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class BuildDrawerListItem extends StatelessWidget {
  final IconData leadingIcon;
  final String? title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const BuildDrawerListItem({
    Key? key,
    required this.leadingIcon,
    this.title,
    this.trailing,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? mainColor,
      ),
      title: Text(title ?? ''),
      trailing: trailing ??
          const Icon(
            Icons.arrow_right,
            color: mainColor,
          ),
      onTap: onTap,
    );
  }
}

class BuildDrawerListItemsDivider extends StatelessWidget {
  const BuildDrawerListItemsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }
}

class DistanceAndTime extends StatelessWidget {
  final PlaceDirections? placeDirections;
  final bool isTimeAndDistanceVisible;

  const DistanceAndTime(
      {Key? key, this.placeDirections, required this.isTimeAndDistanceVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
        top: 0,
        bottom: 570,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.access_time_filled,
                    color: mainColor,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDuration,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.directions_car_filled,
                    color: mainColor,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDistance,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}
