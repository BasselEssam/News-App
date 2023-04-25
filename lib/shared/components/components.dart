import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article,context)
{
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage('${article['image']}'),
                fit: BoxFit.cover
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),)
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget myDivider() => Padding(
padding: const EdgeInsets.only(right: 20,left: 20,top: 5,bottom: 5),
child: Container(color: Colors.grey,height: 1,),
);

Widget articleBuilder(list,context)=>ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context){
    return ListView.separated(
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: list.length,
      physics: BouncingScrollPhysics(),
    );
  },
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);