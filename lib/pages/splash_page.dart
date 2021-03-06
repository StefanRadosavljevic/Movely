import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesapp/models/app_config.dart';
import 'package:moviesapp/service/http_service.dart';
import 'package:moviesapp/services/movie_service.dart';

class SplashPage extends StatefulWidget {
  //when splashscreen is finished this callback will be called
  final VoidCallback onInitComplete;
  const SplashPage(
      {Key key, @required this.onInitComplete, Null Function() oninitComplete})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // when config values are extracted init is completed
    Future.delayed(Duration(seconds: 2)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitComplete(),
      ),
    );
  }

  // get config file for api
  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    // decode json file into data
    final configData = jsonDecode(configFile);

    // create AppConfig object that will be used in HTTPService object.
    getIt.registerSingleton<AppConfig>(AppConfig(
      API_KEY: configData['API_KEY'],
      BASE_API_URL: configData['BASE_API_URL'],
      BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
    ));

    // register create HTTP service object.
    getIt.registerSingleton<HTTPService>(HTTPService());

    // moviservice is dependant on HTTP service.
    getIt.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movely',
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
