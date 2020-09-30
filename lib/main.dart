import 'package:flutter/material.dart';
import 'package:share_ute/views/home_page.dart';
import 'views/login_page.dart';
import 'views/profile_page.dart';


void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHAREute',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SHAREute'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigate to HomePage in views/home_page.dart, which is a StatelessWidget
      body: HomePage(),
    );
  }
}
