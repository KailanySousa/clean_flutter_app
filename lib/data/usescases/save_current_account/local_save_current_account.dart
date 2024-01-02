import 'package:clean_flutter_app/data/cache/cache.dart';
import 'package:clean_flutter_app/domain/entities/entities.dart';
import 'package:clean_flutter_app/domain/helpers/helpers.dart';
import 'package:meta/meta.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';


class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
