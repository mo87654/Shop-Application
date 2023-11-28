import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: cubit.appScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.category
                  ),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.favorite
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings
                  ),
                  label: 'Settings',
                ),
              ],
              onTap: (index){
                cubit.changeNavBar(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        }
    );
  }
}
