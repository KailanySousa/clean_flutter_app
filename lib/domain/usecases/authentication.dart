import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(
    AuthenticationParams params,
  );
}

class AuthenticationParams extends Equatable {
  String email;
  String secret;

  AuthenticationParams({
    @required this.email,
    @required this.secret,
  });

  Map toJson() => {'email': email, 'password': secret};

  @override
  List get props => [email, secret];
}
