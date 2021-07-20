// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bot_toast/bot_toast.dart';
import 'package:cloudwalk/config/config.dart';
import 'package:cloudwalk/pages/pages.dart';
import 'package:cloudwalk/repository/repository.dart';
import 'package:cloudwalk/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: [locator<ApiService>(), locator<LocationInterface>()],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (_) => DashboardBloc(
              apiService: locator<ApiService>(),
              locationService: locator<LocationInterface>()
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            accentColor: const Color(0xFF13B9FF),
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          ),

          builder: EasyLoading.init(builder: BotToastInit()),
          initialRoute: RoutesName.initial,
          navigatorKey: navigationService.navigationKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
