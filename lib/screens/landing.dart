import 'package:flutter/material.dart';
import 'package:memo/screens/authScreen.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/sea.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).primaryColor.withOpacity(.9),
                Theme.of(context).accentColor.withOpacity(.6)
              ])),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Elegance in Writing',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Start taking notes in a \nbetter way today',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color.fromRGBO(0, 0, 71, 1),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
                  },
                  child: Container(
                    height: 50.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 71, 1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                        child: Text(
                      'Start Writing!',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor),
                    )),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
