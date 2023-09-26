import 'dart:async';

import 'package:clean_flutter_app/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';
import 'package:clean_flutter_app/presentation/protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;

  bool get isFormValid =>
      email != null &&
      password != null &&
      emailError == null &&
      passwordError == null;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream
      .map((state) => state.emailError)
      .distinct(); // distinct não permitir emitir dois valores iguais seguidos

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter(
      {@required this.validation, @required this.authentication});

  void _update() => _controller.add(_state); // dispara novo evento

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  Future<void> auth() async {
    await authentication.auth(
        AuthenticationParams(email: _state.email, secret: _state.password));
  }
}
