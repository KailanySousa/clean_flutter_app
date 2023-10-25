import 'package:clean_flutter_app/domain/usecases/usecases.dart';
import 'package:clean_flutter_app/data/usescases/usecases.dart';
import 'package:clean_flutter_app/main/factories/factories.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(
    httpClient: makeHttpAdapter(), url: makeApiUrl('login'));
