import 'package:clean_flutter_app/ui/components/components.dart';
import 'package:clean_flutter_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen(
            (isLoading) {
              if (isLoading) {
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // desabilita a possibilidade fechar o loading clicando fora
                  builder: (context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Aguarde...',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              }
            },
          );

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
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter
                                  .validateEmail, // passando ponteiro, dessa forma, pega o valor automaticamente
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 32,
                          ),
                          child: StreamBuilder<String>(
                              stream: presenter.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Senha',
                                      icon: Icon(
                                        Icons.lock,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      errorText: snapshot.data?.isEmpty == true
                                          ? null
                                          : snapshot.data,
                                    ),
                                    obscureText: true,
                                    onChanged: presenter
                                        .validatePassword // passando ponteiro, dessa forma, pega o valor automaticamente
                                    );
                              }),
                        ),
                        StreamBuilder<bool>(
                            stream: presenter.isFormValidStream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: snapshot.data == true
                                    ? presenter.auth
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
