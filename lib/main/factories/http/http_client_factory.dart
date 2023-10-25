import 'package:clean_flutter_app/data/http/http.dart';
import 'package:http/http.dart';
import 'package:clean_flutter_app/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
