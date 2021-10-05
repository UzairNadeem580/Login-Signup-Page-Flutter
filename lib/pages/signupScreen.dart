import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../backend/authenticate.dart';

import 'WelcomeScreen.dart';
import 'loginScreen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };

  void _showErrorMsg(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Unexpected Error has Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authenticate>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } catch (error) {
      var errorMsg = 'Authentication Failed. Please try again later.';
      _showErrorMsg(errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.redAccent[200],
              Colors.limeAccent[100],
            ])),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Sign up',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PermanentMarker',
                    color: Colors.white)),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 360,
                  width: 300,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          //email
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                labelText: 'Name'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['name'] = value;
                            },
                          ),
                          //email
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),

                          //password
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Password'),
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Enter Valid Password(Min. 6 Character)';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),

                          //Confirm Password
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value != _passwordController.text) {
                                return 'Password doesnot Match';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                            onPressed: () {
                              _submit();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Colors.redAccent,
                            textColor: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an account ?',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Montserrat'),
                              ),
                              SizedBox(width: 5.0),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.redAccent,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
