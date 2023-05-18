import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moviestream/model/trending_movie.dart';

import '../model/credits_model.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {"api_key": "db58f1870d2a2af4f808e3202b566e5f"}),
  );

  Future<TrendingMovieModel?> getTrendingMovies() async {
    try {
      Response response = await _dio.get('/trending/movie/day');

      log('trending movie ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        String jsonRespose = json.encode(response.data);
        return trendingMovieModelFromJson(jsonRespose);
      }
    } on DioError catch (e) {
      print('Error occured at getTrendingMovies : $e');
    }
    return null;
  }

  Future<TrendingMovieModel?> getPopularSeries() async {
    try {
      Response response = await _dio.get('/tv/popular');

      log('popular movie ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        String jsonRespose = json.encode(response.data);
        return trendingMovieModelFromJson(jsonRespose);
      }
    } on DioError catch (e) {
      print('Error occured at getTrendingMovies : $e');
    }
    return null;
  }

  Future<TrendingMovieModel?> getTopRated() async {
    try {
      Response response = await _dio.get('/movie/top_rated');

      log('popular movie ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        String jsonRespose = json.encode(response.data);
        return trendingMovieModelFromJson(jsonRespose);
      }
    } on DioError catch (e) {
      print('Error occured at getTrendingMovies : $e');
    }
    return null;
  }

  Future<Credits?> getCreditsofMoviebyId(int id) async {
    try {
      Response response = await _dio.get('/movie/$id/credits');

      log('popular movie ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        String jsonRespose = json.encode(response.data);
        return creditsFromJson(jsonRespose);
      }
    } on DioError catch (e) {
      print('Error occured at getTrendingMovies : $e');
    }
    return null;
  }

  Future<Credits?> getCreditsofTvbyId(int id) async {
    try {
      Response response = await _dio.get('/tv/$id/credits');

      log('popular movie ${response.statusCode.toString()}');
      if (response.statusCode == 200) {
        String jsonRespose = json.encode(response.data);
        return creditsFromJson(jsonRespose);
      }
    } on DioError catch (e) {
      print('Error occured at getTrendingMovies : $e');
    }
    return null;
  }
}
