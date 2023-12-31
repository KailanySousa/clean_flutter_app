import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
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

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
