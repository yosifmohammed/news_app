import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news/constants/my_colors.dart';
import 'package:news/modules/webViewScreen.dart';

Widget buildArticleItem(Map article, context) => InkWell(
  onTap: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(article['url'])),
    );
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            Container(

              width: 130.0,

              height: 130.0,

              child: ClipRRect(

                borderRadius: BorderRadius.circular(50.0),

                child: article['urlToImage'] == null? Image.asset('assets/images/null_image.png')

                    : Image.network(

                  "${article['urlToImage']}",

                  fit: BoxFit.cover,

                ),

              ),

                //${article['urlToImage']}

            ),

            SizedBox(

              width: 10,

            ),

            Expanded(

              child: Container(

                height: 130,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                        child: Text(

                          '${article['title']}',

                      style: Theme.of(context).textTheme.bodyText1,

                          textDirection: TextDirection.rtl,

                          maxLines: 3,

                          overflow: TextOverflow.ellipsis,

                    )),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(color: MyColors.MyGrey),

                    )

                  ],

                ),

              ),

            )

          ],

        ),

      ),
);

Widget buildArticleScreen(article, context, {bool isSearched = false}) => ConditionalBuilder(
  condition: article.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(article[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.MyGrey
          ),
        ),
      ),
      itemCount: article.length
  ),
  fallback: (context) => isSearched?
  Center(
      child:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/search.png'),
              fit: BoxFit.contain
          ),
        ),
      )
  )
      :Center(
      child: CircularProgressIndicator(
        color: MyColors.MyDeepOrange,
      )),
);
