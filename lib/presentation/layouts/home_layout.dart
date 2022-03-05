import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../modules/home_screen.dart';

class HomeLayout extends StatelessWidget {
  final List<IconData> icons = const [
    Icons.widgets,
    Icons.shopping_bag,
    Icons.person,
    Icons.more_vert,
  ];

  final List<String> titles = const [
    'Menu',
    'Orders',
    'Profile',
    'More',
  ];

  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey,
              child: const Icon(
                Icons.home,
                size: 40,
              ),
              onPressed: () {
                navigateTo(
                  context,
                  const HomeScreen(),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              height: 55,
              gapLocation: GapLocation.center,
              itemCount: icons.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? mainColor : Colors.grey;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 30,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BuildSecondHeader(title: titles[index]),
                    )
                  ],
                );
              },
              activeIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
            body: cubit.pages[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
