import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/constants/my_colors.dart';
import 'package:news/cubit/app_cubit/cubit.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:news/shared/component/build_article_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var list = NewsCubit.get(context).search;
          return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    cursorColor: MyColors.MyDeepOrange,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (String? value){
                      if(value!.isEmpty){
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.search,
                      labelStyle: TextStyle(color: MyColors.MyDeepOrange),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.MyDeepOrange
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.MyDeepOrange
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      prefixIcon: Icon(Icons.search, color: MyColors.MyDeepOrange,),
                    )),
              ),
              Expanded(
                  child: buildArticleScreen(list, context, isSearched: true))
            ],
          ),
        );
      },
    );
  }
}
