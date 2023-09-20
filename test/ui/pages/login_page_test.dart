import 'package:clean_flutter_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    final loginPage = MaterialApp(
      home: LoginPage(),
    );

    await tester.pumpWidget(loginPage); // iniciando componente

    /* 
      não é possível verificar se o errorText (propriedade que indica se possui erro no campo) existe
      dessa forma, uma maneira de verificar se o campo não possui erro, é buscar pelos filhos do campo Email que são do tipo Text
    */
    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
          'quando um TextFormField possuir apenas um filho do tipo Text, significa que não possui erro, porque um dos filhos sempre vai ser o texto do label',
    );

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(
      passwordTextChildren,
      findsOneWidget,
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });
}
