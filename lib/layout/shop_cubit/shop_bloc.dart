import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorite/favorite_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  List<Widget> appScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];

  HomeModel? homeModel;
  Map<int, bool> isFavorite = {};

  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products?.forEach((element) {
        isFavorite.addAll({element.id: element.favorite!});
      });
      emit(HomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCateData() {
    DioHelper.getData(url: CATEGORY, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value?.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(productId) {
    isFavorite[productId] = !isFavorite[productId]!;
    emit(ChangFavoriteState());
    DioHelper.postData(
            url: FAVORITE, data: {'product_id': productId}, token: token)
        ?.then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        isFavorite[productId] = !isFavorite[productId]!;
        toastMessage(message: changeFavoriteModel!.message!, color: Colors.red);
      } else {
        getFavorites();
      }
      emit(ChangFavoriteSuccessState());
    }).catchError((error) {
      isFavorite[productId] = !isFavorite[productId]!;
      emit(ChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    emit(GetFavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value?.data);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  LoginModel? userModel;

  void getUserData() {
    DioHelper.getData(url: PROFILE, token: token,).then((value) {
      userModel = LoginModel.fromJson(value?.data);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }
}
