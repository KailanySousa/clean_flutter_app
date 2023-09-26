import 'package:flutter_test/flutter_test.dart';

abstract class FielValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation implements FielValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if value is not empty', () {
    final sut = RequiredFieldValidation('any value');

    final error = sut.validate('any value');

    expect(error, null);
  });
}
