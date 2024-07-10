import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myrepo = HomeRepository();

  ApiResponse<MoviesListModels> moviesLIst = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesListModels> response) {
    moviesLIst = response;
    notifyListeners();
  }

  Future<void> fetchMoviesList() async {
    setMoviesList(ApiResponse.loading());
    _myrepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
