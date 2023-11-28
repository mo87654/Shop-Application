import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/component/colors.dart';

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
             itemBuilder: (context, index) => itemBuilder(favoriteModel.data!.data![index], context),
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

  Widget itemBuilder(ItemData model, context)=>
      Container(
        height: 120,
        padding: const EdgeInsets.all(15.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child:Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product!.image}'),
                    width: 120,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) {

                      return Center(child: CircularProgressIndicator(),);
                    },
                  ),
                  if(model.product!.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.red,
                      child: Text(
                        '${model.product!.discount}% DISCOUNT',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                        ),
                      ),
                    )
                ],
              ),
            ),SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name}\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1.5
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}  EP',
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if(model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice}  EP',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).isFavorite[model.product!.id]! ?
                        defaultColor
                            :Colors.grey,
                        child: IconButton(
                            onPressed: (){
                              ShopCubit.get(context).changeFavorites(model.product!.id);
                              },
                            icon: Icon(
                              Icons.favorite_border_outlined,
                              size: 14,
                              color: Colors.white,
                            )
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
  );
}
