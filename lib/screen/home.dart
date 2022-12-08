import 'package:flutter/material.dart';
import 'package:flutter_api_call/screen/users/user_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flutter Api Call",
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "Mister Code Diallo (@misterdiallo)",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "This app will only use flutter native dependencies to perform \n - Handling network requests, \n - Integrating APIs, \n - Converting JSON to dart objects \nin the easiest, quickest and professional way.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserListPage()),
                    );
                  },
                  child: const Text("User List"),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Another List"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
