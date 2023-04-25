import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

class NewsLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(icon:Icon(Icons.search),onPressed: (){},),
              IconButton(icon:Icon(Icons.brightness_4_outlined,),
              onPressed:(){
                cubit.changeMode();
              },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            onTap: (index){
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}