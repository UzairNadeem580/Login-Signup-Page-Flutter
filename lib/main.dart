import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/loginScreen.dart';
import 'backend/authenticate.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authenticate(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Signup App',
        home: LoginScreen(),
      ),
    );
  }
}
