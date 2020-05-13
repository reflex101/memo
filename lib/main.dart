import 'package:flutter/material.dart';
import 'package:memo/provider/auth.dart';
import 'package:memo/provider/noteProvider.dart';
import 'package:memo/screens/authScreen.dart';
import 'package:memo/screens/landing.dart';
import 'package:memo/screens/noteOverview.dart';
import 'package:memo/widget/noteModal.dart';
import 'package:memo/widget/tabBar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Notes(),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'Memo',
                theme: ThemeData(
                  primaryColor: Color.fromRGBO(249, 148, 115, 1),
                  accentColor: Color.fromRGBO(255, 236, 210, 1),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home:
                //  auth.isAuth ?
                Navigation() ,
                // : Landing(),
                debugShowCheckedModeBanner: false,
                routes: {
                  AuthScreen.routeName: (ctx) => AuthScreen(),
                  NoteModal.routeName:(ctx) => NoteModal(),
                },
              )),
    );
  }
}
