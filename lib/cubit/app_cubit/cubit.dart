import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/constants/strings.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:news/modules/businessScreen.dart';
import 'package:news/modules/scienceScreen.dart';
import 'package:news/modules/settingScreen.dart';
import 'package:news/modules/sportsScreen.dart';
import 'package:news/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int pageIndex = 0;

  void changeBottomNavBar(int index) {
    pageIndex = index;
    if (index == 1) {
      getSport();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingScreen()
  ];


  List<dynamic> business = [];

  void getBusiness() {
    if (business.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
          url: url,
          query: queryOfBusiness
      )
          .then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      })
          .catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sport = [];

  void getSport() {
    if (sport.length == 0) {
      emit(NewsGetSportLoadingState());
      DioHelper.getData(
          url: url,
          query: queryOfSport
      )
          .then((value) {
        sport = value.data['articles'];
        emit(NewsGetSportSuccessState());
      })
          .catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
          url: url,
          query: queryOfScience)
          .then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      })
          .catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
        url: searchUrl,
        query: {
      'q' : '$value',
      'apiKey' : '5c1bbf7c16cd40e5a0da18e606ebc724'
    })
        .then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}