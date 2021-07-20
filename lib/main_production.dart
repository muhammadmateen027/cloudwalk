import 'dart:async';

import 'package:cloudwalk/app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/config.dart';

void main() async {
  await Initialization.init();

  // That will give you native crash support (for Android and iOS),
  // release health, offline caching and more.

  await runZonedGuarded(
        () async {
      await SentryFlutter.init(
            (options) => options.dsn = dotenv.env['SENTRY_IO'],
        appRunner: () => runApp(const App()),
      );
    },
        (error, stackTrace) async {
      await Sentry.captureException(error, stackTrace: stackTrace);
    },
  );
}

