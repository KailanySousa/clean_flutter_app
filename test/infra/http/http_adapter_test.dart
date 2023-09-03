import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);
  Future<void> request({@required String url, @required String method}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(url as Uri, headers: headers);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(
        url as Uri,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
      ));
    });
  });
}