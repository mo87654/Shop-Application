import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeModel? homeModel = ShopCubit.get(context).homeModel;
          CategoryModel? catemodel = ShopCubit.get(context).categoryModel;
          return homeModel == null
          || ShopCubit.get(context).isFavorite.isEmpty?
          Center(
            child: CircularProgressIndicator(),
          ):
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CarouselSlider(
                  items: homeModel.data?.banners?.map(
                          (e) => Image(
                              image: NetworkImage('${e.image}'),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: CircularProgressIndicator(),);
                              },
                          )
                  ).toList(),
                  options: CarouselOptions(
                    height: 200,
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0
                  )
              ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.separated(
                      itemBuilder: (context, index) => cateItemBuilder(catemodel.data?.data?[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: catemodel!.data!.data!.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.grey,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.77,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                        homeModel.data!.products!.length,
                        (index) => gridItemBuilder(homeModel.data?.products?[index], context)
                    ),

                  ),
                )
              ],
            ),
          );
        });
  }

  Widget gridItemBuilder(ProductsModel? model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(5),
              child: Image(
                image: NetworkImage(model?.image),
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: CircularProgressIndicator(),);
                },
              ),

            ),
            if(model?.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.red,
                child: Text(
                  '${model?.discount}% DISCOUNT',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white
                  ),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model?.name}\n',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.5
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '${model?.price}  EP',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model?.discount != 0)
                    Text(
                      '${model?.oldPrice}  EP',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).isFavorite[model?.id]!?
                    defaultColor
                        :Colors.grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model?.id);
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          size: 14,
                          color: Colors.white,
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],

    ),
  );

  Widget cateItemBuilder(var model)=> Container(
    width: 100,
    height: 100,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: CircularProgressIndicator(),);
          },
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.6),
          child: Text(
            '${model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
