import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopy_app/shared/styles/colors.dart';
import '../cubit/cubit.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
    case ToastStates.ERROR:
      color = Colors.red;
    case ToastStates.WARNING:
      color = Colors.amber;
  }
  return color;
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  bool isPassword = false,
  required bool autofocus,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      autofocus: autofocus,
      onFieldSubmitted: onSubmit,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed as void Function()?,
          icon: Icon(
                  suffix,
                ),
              ) : null,
      ),
    );

Widget defaultButton({
  required double width,
  required Color background,
  bool isUpperCase = true,
  double radius = 0.0,
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        color: Colors.red,
      ),
      child: MaterialButton(
        height: 50.0,
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) => TextButton(
  style: TextButton.styleFrom(
    foregroundColor: Colors.red,
  ),
  onPressed: onPressed,
  child: Text(text.toUpperCase(),),
);

Widget buildListProduct(model, context, {bool isOldPrice = true, isSearch = false}) => Padding(
  padding: EdgeInsets.all(5.0),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
    ),
    height: 100.0,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0,),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(model.image),
                    width: 100,
                    height: 120.0,
                  ),
                ),
              ),
            ),
            if(model.discount !=0 && isOldPrice)
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5.0,),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0,),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0,),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 16,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ?? false ? Colors.red : Colors.transparent,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey[400],
                        child: Icon(
                          Icons.favorite,
                          size: 20.0,
                          color: ShopCubit.get(context).favorites[model.id] ?? false ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);