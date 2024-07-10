import 'package:mvvm/data/network/base_api_service.dart';
import 'package:mvvm/data/network/network_api_service.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/resources/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<MoviesListModels> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MoviesListModels.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
