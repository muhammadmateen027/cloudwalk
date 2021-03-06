// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:cloudwalk/app/app.dart';

import 'config/config.dart';

void main() async{
  await Initialization.init();

  runZonedGuarded(
        () => runApp(const App()),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}