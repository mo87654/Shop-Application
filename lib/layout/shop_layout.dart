import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/component/components.dart';

class ShopLayout extends StatefulWidget {
   ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  void initState() {
    super.initState();
    // ShopCubit.get(context).getFavorites();
    // ShopCubit.get(context).getHomeData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCateData()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){
            // ShopCubit.get(context).getFavorites();
          },
          builder: (context,state){
            ShopCubit cubit = BlocProvider.of(context);
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
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
      ),
    );
  }
}
