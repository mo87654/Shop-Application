
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_cubit/shop_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/component/colors.dart';

navigateToAndReplace(context, direction){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => direction
      )
  );
}
navigateTo(context, direction){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => direction
      )
  );
}

Widget defaultTextField({
  String? label='',
  String? hint,
  required var controller,
  IconData? prefix,
  var inputType,
  bool? isPassword = false,
  IconData? suffix,
  var suffixFunction,
  var validFunction,
  var submitFunction,
  var inputAction
})
  => TextFormField(
    controller: controller,
    keyboardType: inputType,
    obscureText: isPassword!,
    validator: validFunction,
    onFieldSubmitted: submitFunction,
    textInputAction: inputAction,
    /*style: TextStyle(
      fontSize: 18,
    ),*/
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      label: Text(
          '$label'
      ),
      hintText: hint,
      prefixIcon: Icon(
        prefix,
        // size: 27,
      ),
      suffixIcon: IconButton(
          onPressed: suffixFunction,
          icon: Icon(
              suffix,

          )
      ),
    ),
  );

Widget defaultButton({
  required String text,
  required var pressFunction,
})=> Container(
      height: 58,
      width: double.infinity,
      color: defaultColor,
      child: MaterialButton(
          onPressed: pressFunction,
          child: Text(
            '$text',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17
            ),
          ),
      ),
  );

Future<bool?> toastMessage({
  required String message,
  Toast length=Toast.LENGTH_LONG,
  ToastGravity tGravity=ToastGravity.BOTTOM,
  int iosWebtime = 1,
  required Color color,
  Color textColor = Colors.white,
  double fontSize = 16.0,
})=>Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: tGravity,
      timeInSecForIosWeb: iosWebtime,
      backgroundColor: color,
      textColor: textColor,
      fontSize: fontSize,
);

Widget productListBuilder(var model, context,{bool isSearch = false}) {
  if(!isSearch){
    if(ShopCubit.get(context).isFavorite[model.id] == null){
      ShopCubit.get(context).isFavorite.addAll({model.id:true});
    }
  }
  return Container(
    height: 120,
    padding: const EdgeInsets.all(15.0),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
              if(!isSearch)
                if(model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.red,
                    child: Text(
                      '${model.discount}% DISCOUNT',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white
                      ),
                    ),
                  )
            ],
          ),
        ), SizedBox(
          height: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}\n',
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
                    '${model.price}  EP',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(!isSearch)
                    if(model.discount != 0)
                      Text(
                        '${model.oldPrice}  EP',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: (isSearch
                        ? SearchCubit.get(context).searchFav[model.id]!
                        : ShopCubit.get(context).isFavorite[model.id]!) ?
                    defaultColor
                        : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          if (isSearch) {
                            SearchCubit.get(context).changeSearchFavorites(model.id);
                          } else {
                            ShopCubit.get(context).changeFavorites(model.id);
                          }
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
