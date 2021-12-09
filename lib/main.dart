import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nrj_express/screens/new_delivery.dart';
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
  bool authenticated = false;
  late Widget page;
  late String telephone = "";

  _checkToken() async {
    const storage = FlutterSecureStorage();
    var jwt = await storage.read(key: 'token');
    setState(() {
      if (jwt != null) {
        authenticated = true;
      }
    });
  }

  _getPhone(String phoneNumber) {
    setState(() {
      telephone = phoneNumber;
    });
  }

  _loadPage(bool numPage) async {
    setState(() {
      page = authForms(numPage, _loadPage, telephone, _getPhone);
    });
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _MyHomePageState() {
    page = authForms(phoneInput, _loadPage, telephone);
  }

  @override
  Widget build(BuildContext context) {
    return !authenticated
        ? Scaffold(
            body: Container(
                padding: const EdgeInsets.all(15),
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
                child: page))
        : const NewDelivery();
  }
}

authForms(bool phoneInput, ValueChanged<bool> pageChanger, String phone,
    [ValueChanged<String>? phoneGetter]) {
  return (phoneInput && phoneGetter != null)
      ? UserPhoneForm(
          page: phoneInput, loadPage: pageChanger, getPhone: phoneGetter)
      : UserCodeForm(page: phoneInput, loadPage: pageChanger, telephone: phone);
}
