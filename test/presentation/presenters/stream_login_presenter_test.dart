import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  validate({@required String field, @required String value});
}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({@required this.validation});
  void validationEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state); // dispara novo evento
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  Validation validation;
  StreamLoginPresenter sut;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call validation with correct email', () {
    sut.validationEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    when(validation.validate(
            field: anyNamed('field'), value: anyNamed('value')))
        .thenReturn('any error');

    expectLater(sut.emailErrorStream, emits('any error'));

    sut.validationEmail(email);
  });
}