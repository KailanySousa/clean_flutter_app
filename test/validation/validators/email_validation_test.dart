import 'package:clean_flutter_app/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('kailany@gmail.com'), null);
  });

  test('Should return null if email is invalid', () {
    expect(sut.validate('kailanm'), 'Campo inválido');
  });
}
