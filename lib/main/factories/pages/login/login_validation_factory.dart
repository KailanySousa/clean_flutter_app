import 'package:clean_flutter_app/main/builders/builders.dart';
import 'package:clean_flutter_app/presentation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/protocols/protocols.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}
