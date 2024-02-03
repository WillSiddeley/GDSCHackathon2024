import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userUuid = 'Loading UUID...';

  @override
  void initState() {
    super.initState();
    _ensureUserUuid();
  }

  Future<void> _ensureUserUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userUuid = prefs.getString('userUuid');
    if (userUuid == null) {
      userUuid = Uuid().v4();
      await prefs.setString('userUuid', userUuid);
    }
    setState(() {
      if (userUuid != null) {
        _userUuid = userUuid;
      }
      else {
        _userUuid = 'Error';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UUID Example'),
      ),
      body: Center(
        child: Text('User UUID: $_userUuid'),
      ),
    );
  }
}
