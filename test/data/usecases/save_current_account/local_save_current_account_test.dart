import 'package:clean_flutter_app/domain/entities/entities.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({@required this.saveSecureCacheStorage});
  Future<void> save(AccountEntity account) async {
    await saveSecureCacheStorage.saveSecure(key: 'token', value: account.token)
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  test('Should call SaveCacheStorage with corrtect values', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(
        saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());
    sut.save(account);

    verify(saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });
}
