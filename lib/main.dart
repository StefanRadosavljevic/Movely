import 'package:flutter/material.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitComplete: () {
        return null;
      },
    ),
  );
}
