import 'package:clean_flutter_app/presentation/presenters/presenters.dart';
import 'package:clean_flutter_app/presentation/protocols/protocols.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  Validation validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();

    mockValidation();
  });

  test('Should call validation with correct email', () {
    sut.validationEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'any error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'any error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationEmail(email);
    sut.validationEmail(email);
  });

    test('Should emit email null if validation succeeds', () {
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationEmail(email);
    sut.validationEmail(email);
  });
}
