import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomNavItems= [
    BottomNavigationBarItem(
      icon:Icon(Icons.business),
      label: "Business",
      ),
    BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.science),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingssScreen(),
  ];

  void changeIndex(int index){
    currentIndex=index;
    /*if(index==1)
      getSports();
    else if(index==2)
      getScience();*/
    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'api/v4/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'860d89d74f540970d0108617abebdcb1',
        }).then((value){
      //print(value?.data['articles'][0]['title']);
      business=value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports=[];

  void getSports()
  {
    //if(sports.isEmpty)
    //{
      emit(NewsGetSportsLoadingState());

      DioHelper.getData(url: 'api/v4/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'860d89d74f540970d0108617abebdcb1',
          }).then((value){
        sports=value?.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    //}
    //else emit(NewsGetSportsSuccessState());
  }

  List<dynamic> science=[];

  void getScience()
  {
    //if(science.isEmpty)
    //{
      emit(NewsGetScienceLoadingState());

      DioHelper.getData(url: 'api/v4/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apikey':'860d89d74f540970d0108617abebdcb1',
          }).then((value){
        science=value?.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    //}
    //else emit(NewsGetScienceSuccessState());
  }
}