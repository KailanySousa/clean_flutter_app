import 'dart:async';

import 'package:clean_flutter_app/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<String> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    emailErrorController = StreamController<String>();
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    passwordErrorController = StreamController<String>();
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    mainErrorController = StreamController<String>();
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);

    isFormValidController = StreamController<bool>();
    when(presenter.isFormValidStream)
        .thenAnswer((realInvocation) => isFormValidController.stream);

    isLoadingController = StreamController<bool>();
    when(presenter.isLoadingStream)
        .thenAnswer((realInvocation) => isLoadingController.stream);

    final loginPage = MaterialApp(
      home: LoginPage(presenter),
    );
    return await tester.pumpWidget(loginPage); // iniciando componente
  }

  // bloco que roda no final dos testes
  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

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

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);

    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(presenter.validatePassword(password));
  });

  testWidgets('Should presents error if email is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');

    await tester.pump(); // forçando uma nova renderização na tela

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should presents no error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(null);

    await tester.pump(); // forçando uma nova renderização na tela

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should presents no error if email is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');

    await tester.pump();

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should presents error if password is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');

    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should presents no error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);

    await tester.pump();

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should presents no error if password is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('');

    await tester.pump();

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should enable button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(presenter.auth())
        .called(1); // garantir que método será chamado apenas uma vez
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should presents error message if authentication fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (WidgetTester tester) async {
    await loadPage(tester);

    // bloco de código que será executado no final do teste
    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });
}
