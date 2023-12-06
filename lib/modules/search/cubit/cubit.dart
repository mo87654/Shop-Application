import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  Map<int, bool> searchFav = {};
  SearchModel? searchModel;

  void searchProduct (text){
    searchFav.clear();
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          "text":text
        },
      token: token,
    )?.then((value){
      searchModel = SearchModel.fromJson(value.data);
      searchModel?.data?.data?.forEach((element) {
        searchFav.addAll({element.id!: element.inFavorites!});
      });
      // print(searchModel?.data?.data?[1].oldPrice);
      // printFullText(searchModel?.data?.data.toString());
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeSearchFavorites(productId) {
    searchFav[productId] = !searchFav[productId]!;
    emit(ChangFavoriteState());
    DioHelper.postData(
        url: FAVORITE, data: {'product_id': productId}, token: token)
        ?.then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        searchFav[productId] = !searchFav[productId]!;
        toastMessage(message: changeFavoriteModel!.message!, color: Colors.red);
      }else{
        getFavorites();
      }
      emit(ChangFavoriteSuccessState());
    }).catchError((error) {
      searchFav[productId] = !searchFav[productId]!;
      emit(ChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
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
}