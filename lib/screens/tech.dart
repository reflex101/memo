import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class TechScreen extends StatefulWidget {
  @override
  _TechScreenState createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
  
  List data;
  var _isLoading = true;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    final url =
      'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=593be13e502c4d46a85a851100230eb7';
   try{
     var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});

    // print(response.body);
    setState(() {
      var convertData = json.decode(response.body);
      data = convertData['articles'];
      
        
      _isLoading = false;
    });
    return 'success';
   }catch(error){
     throw error;
   }
  }

  // void _showModal(){
  //   showDialog(context: context, builder: (ctx) => SimpleDialog(

  //   ));
  // }

  // Future<void> _launchUrl;
  // String urlLaunch = 'https://www.google.com';

  Future<void> _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        forceSafariVC: false,
      );
    } else {
      throw 'could not lauch $url';
    }
  }

  // @override
  // void dispose() {
  //   getJsonData();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading ? Center(child: CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(0, 0, 71, 1), 
        ),) : ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (ctx, i) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    color: Color.fromRGBO(0, 0, 71, 1),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data[i]['title'],
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('Official News site'),
                                  content: Text(
                                      'Would you like to see the full news?'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          _launchBrowser(data[i]['url']);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'News',
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 71, 1)),
                                        )),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'cancel',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                ));
                      },
                      child: Image.network(
                        data[i]['urlToImage'],
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Published at - ',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 71, 1)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: data[i]['publishedAt'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.0,),
                ],
              );
            }));
  }
}
