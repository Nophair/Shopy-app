import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/categories/categories_screen.dart';
import 'package:shopy_app/components/constants.dart';
import 'package:shopy_app/cubit/states.dart';
import 'package:shopy_app/favorites/favorites_screen.dart';
import 'package:shopy_app/models/categories_model.dart';
import 'package:shopy_app/models/change_favorites_model.dart';
import 'package:shopy_app/models/favorites_model.dart';
import 'package:shopy_app/models/home_model.dart';
import 'package:shopy_app/models/login_model.dart';
import 'package:shopy_app/network/remote/dio_helper.dart';
import 'package:shopy_app/network/remote/end_points.dart';
import 'package:shopy_app/products/products_screen.dart';
import 'package:shopy_app/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];


  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value?.data);
      //print(homeModel?.status);

      homeModel?.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      print(categoriesModel?.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId,
        },
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);

      if(!changeFavoritesModel!.status)
        {
          favorites[productId] =! favorites[productId]!;
        } else
          {
            getFavorites();
          }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId] =! favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value!.data);
      print(favoritesModel!.status);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value!.data);
      print(userModel!.status);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}