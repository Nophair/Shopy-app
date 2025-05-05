import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/cubit/app_cubit.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/cubit/states.dart';
import 'package:shopy_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          child: ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index],context),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: Divider(
                color: Colors.white,
              ),
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0,),
              child: Image(
                image: NetworkImage(model.image),
                width: 100.0,
                height: 85.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
            ),
          ],
        ),
      );
}
