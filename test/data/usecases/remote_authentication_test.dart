import 'package:clean_flutter_app/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  }) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });
  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.secret};

    await httpClient.request(url: url, method: 'post', body: body);
  }
}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  // bloco utilizado para realizar configurações que valem para todos os testes
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(
      httpClient: httpClient,
      url: url,
    );
  });
  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );

    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {'email': params.email, 'password': params.secret},
    ));
  });
}
