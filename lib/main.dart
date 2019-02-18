import 'package:flutter/material.dart';
import 'package:login_sample/email_login_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = EmailLoginBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              stream: _bloc.email,
              builder: (BuildContext streamContext, AsyncSnapshot snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: snapshot.error,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _bloc.emailChanged,
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder<String>(
              stream: _bloc.password,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: snapshot.error,
                  ),
                  obscureText: true,
                  onChanged: _bloc.passwordChanged,
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            StreamBuilder<bool>(
              stream: _bloc.loginCheck,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return RaisedButton(
                    child: Text('Login'),
                    onPressed: snapshot.hasData ? () => print('login') : null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
