import 'package:clean_flutter_app/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = sut.validate('any value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Campo obrigatório');
  });
}
