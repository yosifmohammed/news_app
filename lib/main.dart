import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/constants/my_colors.dart';
import 'package:news/cubit/app_cubit/cubit.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:news/home/news_layout.dart';
import 'package:news/network/remote/cach_helper.dart';
import 'package:news/network/remote/dio_helper.dart';

import 'cubit/theme_cubit/theme_cubit.dart';

void main() async
{
  // sure if every thing is done or no if done run app if no not run app and await
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachedHelper.init();
  bool? isArabic = CachedHelper.getData(key: 'isArabic');
  bool? isDark = CachedHelper.getData(key: 'isDark');
  runApp(MyApp(isDark!, isArabic!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  MyApp(this.isDark, this.isArabic);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSport()..getScience(),),
        BlocProvider(create: (context) => AppCubit()..
        changeAppMode(fromShared: isDark,)..
        changeAppLanguage(fromShared: isArabic,),)
      ],
      child: BlocConsumer<AppCubit, NewsStates>(
          listener: (context, state){},
          builder: (context, state){
            return  MaterialApp(
              locale: AppCubit.get(context).isArabic?
              Locale('ar', ''):
              Locale('en',''),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', ''), // English, no country code
                Locale('ar', ''), // Arabic, no country code
              ],
              theme: ThemeData(
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18.0,
                          color: MyColors.MyBlack
                      )
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: MyColors.MyDeepOrange,
                  ),
                  scaffoldBackgroundColor: MyColors.MyWhite,
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(
                        color: MyColors.MyDeepOrange,
                      ),
                      titleTextStyle: TextStyle(
                          color: MyColors.MyDeepOrange,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                      backwardsCompatibility: false,
                      backgroundColor: MyColors.MyWhite,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: MyColors.MyWhite,
                          statusBarIconBrightness: Brightness.dark
                      )
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: MyColors.MyDeepOrange,
                  )
              ),
              darkTheme: ThemeData(
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18.0,
                          color: MyColors.MyWhite
                      )
                  ),
                  scaffoldBackgroundColor: MyColors.MyBlack,
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                      color: MyColors.MyDeepOrange,
                    ),
                    titleTextStyle: TextStyle(
                        color: MyColors.MyDeepOrange,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                    backwardsCompatibility: false,
                    backgroundColor: MyColors.MyBlack,
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: MyColors.MyBlack,
                        statusBarIconBrightness: Brightness.light
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: MyColors.MyBlack,
                    unselectedItemColor: MyColors.MyWhite60,
                    selectedItemColor: MyColors.MyDeepOrange,
                  )
              ),
              themeMode: AppCubit.get(context).isDark ?
              ThemeMode.dark
                  :
              ThemeMode.light,
              home: Directionality(
                  textDirection: AppCubit.get(context).isArabic?
                  TextDirection.rtl : TextDirection.ltr,
                  child: NewsScreen()),
            );
          } ,
      ),
    );
  }
}
