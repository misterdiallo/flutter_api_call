import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/repository/user_repository.dart';
import 'package:flutter_api_call/api/user/model/user_model.dart';
import 'package:flutter_api_call/screen/error_page.dart';
import 'package:flutter_api_call/screen/users/add_user_page.dart';
import 'package:flutter_api_call/screen/users/user_page.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User?> users = [];
  var futureContent = UserRepository.getAllUsers();
  bool searchBoolean = false;
  final _formKey = GlobalKey<FormBuilderState>();

  bool _searchBoolean = false;
  List<User?> _searchList = [];
  final TextEditingController _searchTextFieldController =
      TextEditingController();

  String title = "";

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchList = [];
          _searchList = users
              .where((mapObject) =>
                  (mapObject!.name).toLowerCase().contains(s.toLowerCase()) ||
                  (mapObject.email).toLowerCase().contains(s.toLowerCase()))
              .toList();
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      controller: _searchTextFieldController,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Type the name',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(
                      id: _searchList[index]!.id,
                    ),
                  ),
                );
              },
              title: Text(_searchList[index]!.name),
              subtitle: Text(_searchList[index]!.email),
            ),
          );
        });
  }

  Widget _defaultListView(users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
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
          );
        });
  }

  @override
  void dispose() {
    _formKey.currentState?.reset();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_searchBoolean ? const Text("Users list") : _searchTextField(),
        automaticallyImplyLeading: !_searchBoolean,
        actions: !_searchBoolean
            ? [
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                        _searchList = [];
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
                    icon: const Icon(Icons.add)),
              ]
            : [
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                      });
                    })
              ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<User?>>(
          stream: Stream.fromFuture(UserRepository.getAllUsers()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ErrorPage(error: snapshot.error.toString()),
                  TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Refresh"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.refresh_sharp),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              users = snapshot.data!;
              return !_searchBoolean
                  ? _defaultListView(users)
                  : _searchListView();
            }
          },
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
