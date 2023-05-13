import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/shared/components/components.dart';

import '../../layout/cubit/states.dart';

class SearchScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list=BlocProvider.of<NewsCubit>(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value)
                  {
                    if(value==null || value.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      labelText: 'Search'
                  ),
                  onChanged: (value){
                    BlocProvider.of<NewsCubit>(context).getSearch(value);
                  },
                ),
                Expanded(
                    child: articleBuilder(list, context,isSearch: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}