import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nrj_express/screens/home_screen.dart';
import 'package:nrj_express/src/authentication/user_code_form.dart';
import 'src/authentication/user_phone_form.dart';

void main() async {
  await dotenv.load();
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

  _loadPage(bool phonePage) async {
    setState(() {
      page = authForms(phonePage, _loadPage, telephone, _getPhone);
    });
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  _MyHomePageState() {
    page = phoneInput
        ? authForms(phoneInput, _loadPage, telephone, _getPhone)
        : authForms(phoneInput, _loadPage, telephone);
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
        : HomeScreen();
  }
}

authForms(bool phoneInput, ValueChanged<bool> pageChanger, String phone,
    [ValueChanged<String>? phoneGetter]) {
  return (phoneInput && phoneGetter != null)
      ? UserPhoneForm(
          page: phoneInput, loadPage: pageChanger, getPhone: phoneGetter)
      : UserCodeForm(page: phoneInput, loadPage: pageChanger, telephone: phone);
}
