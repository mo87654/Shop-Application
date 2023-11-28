import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/categoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CategoryModel? cateModel = ShopCubit.get(context).categoryModel;
          return cateModel == null?
          Center(child: CircularProgressIndicator(),)
          :ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage('${cateModel.data?.data[index].image}'),
                      height: 80,
                      width: 80,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: CircularProgressIndicator(),);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${cateModel.data?.data[index].name}',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Spacer(),
                    Icon(
                        Icons.arrow_forward_ios
                    )
                  ],
                ),
              ),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(horizontal: 15),
              ),
              itemCount: cateModel.data!.data.length
          );
        },
    );
  }
}
