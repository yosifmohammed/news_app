import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_cubit/cubit.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/modules/searchScreen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                }
                ,
                icon: Icon(Icons.search)
            ),
          ],
          title: Text(
              AppLocalizations.of(context)?.newsApp ?? 'News',
          ),
        ),
        body: cubit.screens[cubit.pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: AppLocalizations.of(context)?.business ?? 'Business'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: AppLocalizations.of(context)?.sport ?? 'Sport'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: AppLocalizations.of(context)?.science ?? 'Science'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)?.setting ?? 'Setting'
            ),
          ],
          currentIndex: cubit.pageIndex,
          onTap: (index){
            cubit.changeBottomNavBar(index);
          },
        ),
      );}
    );
  }
}
