import 'package:clean_flutter_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FIXME: definindo o modo de cor para a status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryLight = Color.fromRGBO(188, 71, 123, 1);
    return MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryDark,
        primaryColorLight: primaryLight,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          alignLabelWithHint: true,
        ),

        /* 
          FIXME
          
          O trecho abaixo define o estilo dos botões, quando usado RaisedButton
          
          Devido as novas atualizações do Flutter, o RaisedButton foi depreciado,
          sendo substituído pelo ElevatedButton
        */

        // buttonTheme: ButtonThemeData(
        //   colorScheme: ColorScheme.light(
        //     primary: primaryColor,
        //   ),
        //   buttonColor: primaryColor,
        //   splashColor: primaryLight,
        //   padding: EdgeInsets.symmetric(
        //     vertical: 10,
        //     horizontal: 20,
        //   ),
        //   textTheme: ButtonTextTheme.primary,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        // ),

        // FIXME: O trecho abaixo define o estilo dos botões, quando usado ElevatedButton

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: LoginPage(null),
    );
  }
}
