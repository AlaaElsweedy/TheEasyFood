import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/maps/maps_cubit.dart';
import 'package:talabat_app/data/repository/map_repository.dart';
import 'package:talabat_app/data/services/local/cache_helper.dart';
import 'package:talabat_app/data/services/remote/place_web_services.dart';
import 'package:talabat_app/presentation/layouts/home_layout.dart';
import 'package:talabat_app/presentation/modules/login/login_screen.dart';
import 'package:talabat_app/presentation/modules/on_boarding_screen.dart';
import 'package:talabat_app/shared/bloc_observer.dart';
import 'package:talabat_app/shared/components/styles/styles.dart';
import 'package:talabat_app/shared/constants.dart';

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
              ..getRestaurants()),
        BlocProvider(
          create: (context) => MapsCubit(MapRepository(PlacesWebservices())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
      // child: BlocConsumer<AppCubit, AppStates>(
      //   listener: (context, state) {},
      //   builder: (context, state) => MaterialApp(
      //     debugShowCheckedModeBanner: false,
      //     theme: lightTheme,
      //     home: startWidget,
      //   ),
      // ),
    );
  }
}
