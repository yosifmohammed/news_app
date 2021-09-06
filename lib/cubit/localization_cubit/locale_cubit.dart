import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(SelectedLocale(Locale('en')));
  static LocaleCubit get(context) => BlocProvider.of(context);

  void toArabic(){
    emit(SelectedLocale(Locale('ar')));
  }

  void toEnglish(){
    emit(SelectedLocale(Locale('en')));
  }

}