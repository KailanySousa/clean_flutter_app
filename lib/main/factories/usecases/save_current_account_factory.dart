import 'package:clean_flutter_app/data/usescases/save_current_account/save_current_account.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';

import '../factories.dart';

SaveCurrentAccount makeLocalSaveCurrentAccount() =>
    LocalSaveCurrentAccount(saveSecureCacheStorage: makeLocalStorageAdapter());
