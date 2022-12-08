import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/repository/user_repository.dart';
import 'package:flutter_api_call/api/user/model/user_model.dart';
import 'package:flutter_api_call/screen/users/user_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Users"),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(UserRepository.fetchUserList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(
                      id: users[index].id,
                    ),
                  ),
                );
              },
              title: Text(users[index].name),
              subtitle: Text(users[index].email),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
