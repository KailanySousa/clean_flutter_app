import 'package:clean_flutter_app/main/factories/factories.dart';
import 'package:flutter/material.dart';
import 'package:clean_flutter_app/ui/pages/pages.dart';

Widget makeLoginPage() => LoginPage(makeGetxLoginPresenter());
