import 'package:flutter/material.dart';
import 'package:nrj_express/src/authentication/user_code_form.dart';
import 'src/authentication/user_phone_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool phoneInput = true;
  late Widget page;

  _loadPage(bool numPage) {
    setState(() {
      page = authForms(numPage, _loadPage);
    });
  }

  _MyHomePageState() {
    page = authForms(phoneInput, _loadPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(15),
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
            child: page));
  }
}

authForms(bool phoneInput, ValueChanged<bool> callback) {
  return (phoneInput)
      ? UserPhoneForm(
          page: phoneInput,
          loadPage: callback,
        )
      : UserCodeForm(
          page: phoneInput,
          loadPage: callback,
        );
}
