import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:news/network/remote/cach_helper.dart';

class AppCubit extends Cubit<NewsStates>{
  AppCubit() : super(NewsInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isArabic = false;
  void changeAppLanguage({bool? fromShared}){
    if(fromShared != null){
      isArabic = fromShared;
      emit(NewsChangeLanguageState());
    }else{
      CachedHelper.putData(key: 'isArabic', value: isArabic).
      then((value){
        emit(NewsChangeModeState());
      });
    }
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(NewsChangeModeState());
    }else{
      CachedHelper.putData(key: 'isDark', value: isDark).
      then((value){
        emit(NewsChangeModeState());
      });
    }

  }
}