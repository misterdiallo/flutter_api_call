import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/repository/user_repository.dart';
import 'package:flutter_api_call/api/user/model/user_model.dart';
import 'package:flutter_api_call/screen/error_page.dart';
import 'package:flutter_api_call/screen/users/add_user_page.dart';
import 'package:flutter_api_call/screen/users/user_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User?> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User?>>(
      stream: Stream.fromFuture(UserRepository.fetchUserList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return ErrorPage(
            error: snapshot.error.toString(),
            goBackPage: null,
          );
        }
        users = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("List Users"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddUserPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPage(
                        id: users[index]!.id,
                      ),
                    ),
                  );
                },
                title: Text(users[index]!.name),
                subtitle: Text(users[index]!.email),
              ),
            ),
          ),
        );
      },
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
