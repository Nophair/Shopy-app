import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/cubit/app_cubit.dart';
import 'package:shopy_app/cubit/app_states.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/layout/home_layout.dart';
import 'package:shopy_app/modules/login/login_screen.dart';
import 'package:shopy_app/network/local/cache_helper.dart';
import 'package:shopy_app/network/remote/dio_helper.dart';
import 'package:shopy_app/on_boarding/on_boarding_screen.dart';
import 'package:shopy_app/shared/bloc_observer.dart';
import 'package:shopy_app/shared/styles/themes.dart';
import 'package:shopy_app/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Widget widget;

  print(token.toString());
  if (token is String) {
    token = token;
  } else {
    token = null;
  }

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
      isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({required this.isDark, required this.startWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}