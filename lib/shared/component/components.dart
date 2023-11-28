
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String? label,
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