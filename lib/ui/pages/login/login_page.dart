import 'package:clean_flutter_app/ui/components/components.dart';
import 'package:clean_flutter_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen(
            (isLoading) {
              if (isLoading) {
                showLoading(context);
              } else {
                hideLoading(context);
              }
            },
          );

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LoginHeader(),
                Headline1(
                  text: 'Login',
                ),
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          EmailInput(),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 32,
                            ),
                            child: PasswordInput(),
                          ),
                          StreamBuilder<bool>(
                              stream: widget.presenter.isFormValidStream,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  onPressed: snapshot.data == true
                                      ? widget.presenter.auth
                                      : null,
                                  child: Text(
                                    'Entrar'.toUpperCase(),
                                  ),
                                );
                              }),
                          TextButton.icon(
                            onPressed: () {},
                            label: Text('Criar conta'),
                            icon: Icon(Icons.person),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}