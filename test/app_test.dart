
import 'package:cloudwalk/app/app.dart';
import 'package:cloudwalk/config/config.dart';
import 'package:cloudwalk/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders DashboardPage', (tester) async {
      await Initialization.init();
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardPage), findsOneWidget);
    });
  });
}
