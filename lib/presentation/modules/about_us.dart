import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: paddingAll,
          child: Column(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/image.jpg'),
                radius: 70,
              ),
              sizedBox15,
              Text('About Us'),
              sizedBox10,
              Text(
                'Flutter developer graduated from the faculty of computer and information sciences, Mansoura University. I still learning to improve my skills.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                ),
              ),
              sizedBox28,
              BuildIcon(),
            ],
          ),
        ),
      ),
    );
  }
}

List<Color> colors = const [
  Colors.blue,
  Colors.black,
  Colors.blueAccent,
];

List<IconData> icons = const [
  FontAwesomeIcons.facebook,
  FontAwesomeIcons.github,
  FontAwesomeIcons.linkedin,
];

List<String> urls = const [
  'https://www.facebook.com/alaa.elsweedy.9',
  'https://github.com/AlaaElsweedy',
  'https://www.linkedin.com/in/alaa-elsweedy-1a900720a',
];

class BuildIcon extends StatelessWidget {
  const BuildIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SocilaButton(
            color: colors[index],
            url: urls[index],
            icon: icons[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: colors.length,
      ),
    );
  }
}

class SocilaButton extends StatelessWidget {
  final Color color;
  final String url;
  final IconData icon;

  const SocilaButton({
    Key? key,
    required this.color,
    required this.url,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        launchUrl(url);
      },
      icon: FaIcon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}

Future launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
