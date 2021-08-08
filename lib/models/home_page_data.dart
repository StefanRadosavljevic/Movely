import 'package:moviesapp/models/search_category.dart';

import 'movie.dart';

class HomePageData {
  final List<Movie> movies;
  final int page;
  final String searchCategory;
  final String searchText;

  HomePageData({
    this.movies,
    this.page,
    this.searchCategory,
    this.searchText,
  });

  HomePageData.initial()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  HomePageData copyWith({
    List<Movie> movies,
    int page,
    String searchCategory,
    String searchText,
  }) {
    return HomePageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
