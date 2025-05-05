import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/constants.dart';
import 'package:shopy_app/models/search_model.dart';
import 'package:shopy_app/network/remote/dio_helper.dart';
import 'package:shopy_app/network/remote/end_points.dart';
import 'package:shopy_app/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super (SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data:
      {
        'text':text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}