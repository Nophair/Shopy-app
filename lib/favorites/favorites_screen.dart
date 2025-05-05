import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {  },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) {
            if (ShopCubit.get(context).favoritesModel!.data.data.isEmpty ||
                (ShopCubit.get(context).favoritesModel!.data.data.length == 1 && ShopCubit.get(context).favoritesModel!.data.data.first == false)) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(
                      Icons.favorite,
                      size: 60.0,
                      color: Colors.grey,
                    ),
                    Text(
                      'No Favorites Yet, Add Some Favorites',
                      style: TextStyle(
                        fontFamily: 'NoyhR',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ]
                ),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data.data[index].product, context,),
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0,),
                  child: Divider(color: Colors.white,),
                ),
                itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
              );
            }
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
