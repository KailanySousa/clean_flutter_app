import 'package:clean_flutter_app/validation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

class ValidationBuilder {
  static ValidationBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._(); // criar um construtor privado

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
