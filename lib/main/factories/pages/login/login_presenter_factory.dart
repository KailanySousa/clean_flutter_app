import 'package:clean_flutter_app/main/factories/factories.dart';
import 'package:clean_flutter_app/main/factories/pages/login/login_validation_factory.dart';
import 'package:clean_flutter_app/presentation/presenters/presenters.dart';
import 'package:clean_flutter_app/ui/pages/pages.dart';

LoginPresenter makeStremLoginPresenter() => StreamLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
    );

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
    );
