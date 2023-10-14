import 'package:clean_flutter_app/presentation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  validate({String field, String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  test('Should return null if all validation returns null or empty', () {
    final validation1 = FieldValidationSpy();

    when(validation1.field).thenReturn('any_field');
    when(validation1.field).thenReturn(null);

    final validation2 = FieldValidationSpy();

    when(validation2.field).thenReturn('any_field');
    when(validation2.field).thenReturn('');

    final sut = ValidationComposite([validation1, validation2]);
    final error = sut.validate(field: 'any_field', value: 'value');

    expect(error, null);
  });
}
