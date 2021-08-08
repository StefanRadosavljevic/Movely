import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesapp/models/home_page_data.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/services/movie_service.dart';

class HomePageDataController extends StateNotifier<HomePageData> {
  HomePageDataController([HomePageData state])
      : super(state ?? HomePageData.initial()) {
    getMovies();
  }
  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> _movies = [];
      _movies = await _movieService.getPopularMovies(page: state.page);
    } catch (e) {}
  }
}
