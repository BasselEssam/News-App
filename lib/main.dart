import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/cubit/cubit.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getBool(key: 'isDark');
  int? sharedIndex=CacheHelper.getInt(key: 'currentIndex');

  runApp(MyApp(isDark,sharedIndex));
}

class MyApp extends StatelessWidget{
  bool? isDark;
  int? sharedIndex;
  MyApp(this.isDark,this.sharedIndex);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience()..setMode(isDark)..setIndex(sharedIndex),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder:(context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
            theme: ThemeData(
              primarySwatch: Colors.purple,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                elevation: 0,
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.purple,
                type: BottomNavigationBarType.fixed,
                elevation: 25,
                backgroundColor: Colors.white,
                showUnselectedLabels: false,
                selectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // floatingActionButtonTheme: FloatingActionButtonThemeData(
              //   backgroundColor: Colors.deepOrange,
              // ),
            ),
            themeMode: BlocProvider.of<NewsCubit>(context).isDark?ThemeMode.dark:ThemeMode.light,
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                elevation: 0,
                titleTextStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
                iconTheme: IconThemeData(
                    size: 26,
                    color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                showUnselectedLabels: false,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}