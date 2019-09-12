import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habito_de_ler/pages/main/home_page.dart';
import 'package:habito_de_ler/pages/search_book_page.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('HomePage click in going SearchPage',
      (WidgetTester tester) async {
    final mockObservation = MockNavigatorObserver();
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
      navigatorObservers: [mockObservation],
    ));

    var widgetHomePage = tester.widget(find.byType(HomePage));
    print(widgetHomePage);

    // Executa o click
    await tester.tap(find.byIcon(Icons.add));
    // Espera carregar o resultado
    await tester.pumpAndSettle();

    var widgetSearchBookPage = tester.widget(find.byType(SearchBookPage));
    print(widgetSearchBookPage.toString());

    // Pagina esperada
    expect(widgetSearchBookPage.toString(), 'SearchBookPage');
  });

  testWidgets('Swipe remove item in HomePage', (WidgetTester tester) async {
    final mockObservation = MockNavigatorObserver();
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
      navigatorObservers: [mockObservation],
    ));

    final gesture = await tester.startGesture(Offset.zero);

    await gesture.moveBy(const Offset(0, 100));
    // Espera carregar o resultado
    await tester.pump();

    print(find.byKey(Key('listCards')).at(0).allCandidates.toList());
  });
}
