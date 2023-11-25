import 'package:dio/dio.dart';
import 'package:movie_app/utils/constant_data.dart';

import '../../core/api.dart';
import '../models/movie_model.dart';

class GetMovies {
  final Api api = Api();
  Future<List<MovieModel>> getNowPlayingMovies(int page) async {
    try {
      Response response = await api.sendRequest
          .get("/now_playing?api_key=${ConstantData.apiKey}&page=$page");

      if (response.statusCode == 200) {
        return (response.data['results'] as List<dynamic>)
            .map((json) => MovieModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getTopRatedMovies(int page) async {
    try {
      Response response = await api.sendRequest
          .get("/top_rated?api_key=${ConstantData.apiKey}&page=$page");

      if (response.statusCode == 200) {
        return (response.data['results'] as List<dynamic>)
            .map((json) => MovieModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      rethrow;
    }
  }
}
