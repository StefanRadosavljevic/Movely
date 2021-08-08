import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/models/movie.dart';
import 'package:moviesapp/models/search_category.dart';

class HomePage extends ConsumerWidget {
  double _deviceHeight;
  double _deviceWidth;

  TextEditingController _searchTextFieldController;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _searchTextFieldController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/poster.png',
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
        width: _deviceWidth * 0.88,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _topBarWidget(),
            Container(
              height: _deviceHeight * 0.80,
              padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.05),
              child: _moviesListViewWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          _searchFieldWidget(),
          _categorySelectorWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.50,
      child: Center(
        child: TextField(
          controller: _searchTextFieldController,
          onSubmitted: (_input) {},
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(Icons.search, color: Colors.white24),
            hintStyle: TextStyle(color: Colors.white54),
            filled: false,
            fillColor: Colors.white24,
            hintText: 'Search for a movie',
          ),
        ),
      ),
    );
  }

  Widget _categorySelectorWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (_value) {},
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = [];

    for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
        name: "Fight Club",
        description:
            "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
        isAdult: false,
        backdropPath: "/rr7E0NoGKxvbkb89eR1GwfoYjpA.jpg",
        posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
        language: "EN",
        rating: 8.4,
        releaseDate: "1999-10-15",
      ));
    }
    if (_movies.length != 0) {
      return ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {},
                child: Text(_movies[_count].name),
              ),
            );
          });
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
