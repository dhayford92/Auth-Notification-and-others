import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socailauthapp/user_provider.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('${userProvider.user.fullname}'),
              subtitle: const Text('User name'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text('${userProvider.user.phone}'),
              subtitle: const Text('User number'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text('${userProvider.user.email}'),
              subtitle: const Text('User email'),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () {},
              color: Colors.redAccent,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
