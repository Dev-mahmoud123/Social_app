import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// TODO: constant variables
var uid; // user token


//TODO: Widgets
// Text Field
Widget defaultTextField({
  TextEditingController controller,
  TextInputType type,
  Function onChange,
  onSaved,
  validator,
  onFieldSubmitted,
  suffixPress,
  bool isObscure = false,
  String label,
  hint,
  Widget prefixIcon,
  suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onChanged: onChange,
    obscureText: isObscure,
    onSaved: onSaved,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}

// Text Button
Widget defaultTextButton({
  @required Function press,
  @required String text,
  Color color,
  double fontSize,
}) {
  return TextButton(
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
    ),
    onPressed: press,
  );
}

defaultToast({@required String message, ToastState state}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { Success, Error, Waring }

Color toastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Success:
      color = Colors.green;
      break;
    case ToastState.Error:
      color = Colors.red;
      break;
    case ToastState.Waring:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateAndFinish({context, widget}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

void navigateTo({context, widget}) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

Widget myDivider(){
  return Divider(
    color: Colors.black12,
    height: 1.0,
  );

}