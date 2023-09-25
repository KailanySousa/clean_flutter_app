import 'dart:async';

import 'package:meta/meta.dart';
import 'package:clean_flutter_app/presentation/protocols/protocols.dart';

class LoginState {
  String emailError;
  String passwordError;

  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream
      .map((state) => state.emailError)
      .distinct(); // distinct não permitir emitir dois valores iguais seguidos

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({@required this.validation});

  void _update() => _controller.add(_state); // dispara novo evento

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }
}
