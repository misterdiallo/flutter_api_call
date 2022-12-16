import 'package:flutter/material.dart';
import 'package:flutter_api_call/screen/photos/photos_list_page.dart';
import 'package:flutter_api_call/screen/users/user_list_page.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

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
              const SizedBox(
                height: 5,
              ),
              Text(
                "Mister  Diallo (@misterdiallo)",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 13.0, color: Colors.white),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 2000),
                      animatedTexts: [
                        TyperAnimatedText('Follow me: @misterdiallo'),
                        TyperAnimatedText('A passionate Guinean'),
                        TyperAnimatedText('and Flutter Lover'),
                        TyperAnimatedText('By - Mister Diallo'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "This app will only use flutter native dependencies to perform \n - Handling network requests from API or Server, \n - Integrating APIs data, \n - Converting JSON to dart objects \nin the easiest, quickest and professional way.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "API:  https://jsonplaceholder.typicode.com",
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      child: const Text("User API"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhotoListPage()),
                        );
                      },
                      child: const Text("Photo API"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
