import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/cubit/app_cubit.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/cubit/states.dart';
import 'package:shopy_app/models/categories_model.dart';
import 'package:shopy_app/models/home_model.dart';
import 'package:shopy_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoriesModel, context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
            color: Colors.red,
          ),
          ),
        );
      },
    );
  }

  Widget builderWidget(HomeModel? model, CategoriesModel? categoriesModel, context) => Container(
        color: AppCubit.get(context).isDark ? Colors.black : Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model?.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Products',
                      style: TextStyle(
                        color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  children: List.generate(
                    model!.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                      child: Image(
                        image: NetworkImage(
                          model.image,
                        ),
                        width: double.infinity,
                        height: 150.0,
                      ),
                    ),
                  ),
                  if (model.discount != 0)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 9.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.transparent,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey[400],
                              child: Icon(
                                Icons.favorite,
                                size: 20.0,
                                color: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.white,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.zero,
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
}
