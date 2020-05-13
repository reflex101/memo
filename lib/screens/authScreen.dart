import 'package:flutter/material.dart';
import 'package:memo/models/httpException.dart';
import 'package:memo/provider/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignUp, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor.withOpacity(1),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   'Welcome to memo',
          //   style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          // ),
          AuthDetails()
        ],
      )),
    );
  }
}

class AuthDetails extends StatefulWidget {
  const AuthDetails({
    Key key,
  }) : super(key: key);

  @override
  _AuthDetailsState createState() => _AuthDetailsState();
}

class _AuthDetailsState extends State<AuthDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'name': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error occured'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('okay'))
              ],
            ));
  }

  Future<void> _switchLogin() async {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _submit() async {
    // if (!_formKey.currentState.validate()) {
    //   // Invalid!
    //   return;
    // }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
        // Navigator.of(context).pushNamed(Navigations.routeName);
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'auntication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Email Exists';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Weak password, try again';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'No such Email';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage = 'TOo many attempts, please try later';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'could not authenticate you, please try again';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Text(
              _authMode == AuthMode.Login
                  ? 'Welcome back!'
                  : 'Start experiencing stuffs ',
              style: TextStyle(
                fontSize: 15.0,
                color: Color.fromRGBO(0, 0, 71, 1),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 20.0,
                        offset: Offset(10, 15),
                        spreadRadius: -20.0),
                  ],
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'E-Mail',
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 71, 1),
                      ),
                      enabledBorder: InputBorder.none, 
                      focusedBorder: InputBorder.none
                      ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 20.0,
                        offset: Offset(10, 15),
                        spreadRadius: -20.0),
                  ],
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(0, 0, 71, 1),
                  )),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: (value) {
                _authData['password'] = value;
              },
              controller: _passwordController,
            ),
              )),
              SizedBox(height: 10.0,),
            _authMode == AuthMode.SignUp
                ? Column(
                    children: <Widget>[

                      Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 20.0,
                        offset: Offset(10, 15),
                        spreadRadius: -20.0),
                  ],
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 71, 1),
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                        controller: _passwordController,
                      ),))
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: 'Name',
                      //       labelStyle: TextStyle(
                      //         color: Color.fromRGBO(0, 0, 71, 1),
                      //       )),
                      //   onSaved: (value) {
                      //     _authData['name'] = value;
                      //   },
                      // ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: _switchLogin,
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 71, 1),
                    ),
                  ),
                ),
                // _isLoading  ? CircularProgressIndicator() : GestureDetector(
                //     onTap: _submit,
                //     child: Container(
                //       height: 40.0,
                //       width: 120.0,
                //       decoration: BoxDecoration(
                //           // gradient: LinearGradient(colors: [
                //           //   Theme.of(context).primaryColor,
                //           //   Theme.of(context).accentColor
                //           // ],
                //           // begin: Alignment.topLeft,
                //           // end: Alignment.bottomRight
                //           // ),
                //           color: Theme.of(context).primaryColor,
                //           borderRadius: BorderRadius.circular(20.0)),
                //       child: Center(
                //         child: Text(
                //           _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                //           style: TextStyle(color: Colors.white, fontSize: 16.0),
                //         ),
                //       ),
                //     ),
                //   ),

                _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      )
                    : RaisedButton(
                        child: Text('LOGIN'),
                        onPressed: _submit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
