import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/cubit.dart';
import 'business_logic/maps/maps_cubit.dart';
import 'data/repository/map_repository.dart';
import 'data/services/place_web_services.dart';
import 'helpers/cache_helper.dart';
import 'presentation/layouts/home_layout.dart';
import 'presentation/modules/login/login_screen.dart';
import 'presentation/modules/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/styles/styles.dart';
import 'shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Transparent Statusbar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await CacheHelper.init();
  await Firebase.initializeApp();

  Widget startWidget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  if (onBoarding != null) {
    if (uId != null) {
      startWidget = const HomeLayout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit()
            ..getCategories()
            ..getMeals()
            ..getRestaurants()
            ..getCartProducts()
            ..getFavorites()
            ..getOrdersHistory(),
        ),
        BlocProvider(
          create: (context) => MapsCubit(MapRepository(PlacesWebservices())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
