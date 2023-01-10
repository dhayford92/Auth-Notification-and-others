import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socailauthapp/data_servers.dart';
import 'package:socailauthapp/homepage.dart';

import 'user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: MaterialApp(
        title: 'Google Authenticate API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          HomePage.id: (context) => const HomePage(),
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login Page',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Email here',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      controller: email,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () => GoogleAuth.signout(context),
                      color: Colors.blueGrey,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        context.loaderOverlay.show();
                        GoogleAuth.googlelogin(context).then((value) {
                          if (value['status'] == true) {
                            userProvider.setUser(value['data']);
                            Navigator.pushReplacementNamed(
                                context, HomePage.id);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("$value['message']")));
                          }
                        }).catchError((error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("$error")));
                        });
                      },
                      color: Colors.redAccent,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('login with google'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
