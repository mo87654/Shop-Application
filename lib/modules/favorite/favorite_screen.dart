import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/component/components.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        FavoriteModel? favoriteModel = ShopCubit.get(context).favoriteModel;
        return state is GetFavoriteLoadingState
            || favoriteModel == null
            || ShopCubit.get(context).isFavorite.isEmpty ?
        Center(child: CircularProgressIndicator(),)
        : ListView.separated(
             physics: BouncingScrollPhysics(),
             itemBuilder: (context, index) => productListBuilder(favoriteModel.data!.data![index].product!, context),
             separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(horizontal: 15),
                ),
            itemCount: favoriteModel.data!.data!.length,
        );
      },
    );
  }

}
