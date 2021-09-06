import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/app_cubit/cubit.dart';
import 'package:news/cubit/app_cubit/states.dart';
import 'package:news/shared/component/build_article_item.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).sport;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){
      },
      builder: (context, state){
        return buildArticleScreen(list, context);
      },
    );
  }
}
