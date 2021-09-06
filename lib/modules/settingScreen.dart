import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/constants/my_colors.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/cubit/theme_cubit/theme_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, NewsStates>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(
                      Icons.brightness_4_outlined,
                      color: MyColors.MyDeepOrange,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text(
                      AppLocalizations.of(context)?.darkMode ?? 'DarkMode',
                    style: Theme.of(context).textTheme.bodyText1
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Transform.scale(
                      scale: 0.8,
                          child: FlutterSwitch(
                            width: 110.0,
                            height: 50.0,
                            valueFontSize: 22.0,
                            toggleSize: 30.0,
                            value: cubit.isDark,
                            borderRadius: 30.0,
                            activeColor: MyColors.MyDeepOrange,
                            activeIcon: Icon(Icons.brightness_4),
                            inactiveIcon: Icon(Icons.brightness_4_outlined),
                            padding: 10.0,
                            showOnOff: true,
                            onToggle: (value) {
                              cubit.isDark = value;
                              cubit.changeAppMode();
                            },
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(
                      Icons.translate,
                      color: MyColors.MyDeepOrange,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Text(
                      AppLocalizations.of(context)?.language ?? 'Language',
                      style: Theme.of(context).textTheme.bodyText1
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Transform.scale(
                        scale: 0.8,
                         child: FlutterSwitch(
                           width: 110.0,
                           height: 50.0,
                           valueFontSize: 22.0,
                           toggleSize: 30.0,
                           value: cubit.isArabic,
                           activeIcon: Icon(Icons.language),
                           inactiveIcon: Icon(Icons.language_outlined),
                           borderRadius: 30.0,
                           padding: 10.0,
                           showOnOff: true,
                           activeColor: MyColors.MyDeepOrange,
                           onToggle: (value) {
                             cubit.isArabic = value;
                             cubit.changeAppLanguage();
                           },
                         ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
        listener: (context, state) {}
    );
  }
}
