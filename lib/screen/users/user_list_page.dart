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
  bool searchBoolean = false; //add

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User?>>(
      stream: Stream.fromFuture(UserRepository.getAllUsers()),
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
            title: searchBoolean ? searchTextField() : const Text("List Users"),
            actions: searchBoolean
                ? null
                : [
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            //add
                            searchBoolean = true;
                          });
                        }),
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

  Widget searchTextField() {
    return Row(
      children: const [
        TextField(
          autofocus: true, //Display the keyboard when TextField is displayed
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textInputAction: TextInputAction
              .search, //Specify the action button on the keyboard
          decoration: InputDecoration(
            //Style of TextField
            enabledBorder: UnderlineInputBorder(
                //Default TextField border
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                //Borders when a TextField is in focus
                borderSide: BorderSide(color: Colors.white)),
            hintText:
                'Search', //Text that is displayed when nothing is entered.
            hintStyle: TextStyle(
              //Style of hintText
              color: Colors.white60,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
