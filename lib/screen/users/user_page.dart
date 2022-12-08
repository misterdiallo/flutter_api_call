import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/model/user_model.dart';

import 'package:flutter_api_call/api/user/repository/user_repository.dart';
import 'package:flutter_api_call/screen/error_page.dart';
import 'package:flutter_api_call/screen/users/update_user_page.dart';

class UserPage extends StatefulWidget {
  int id;
  UserPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.fromFuture(UserRepository.getOneUser(id: widget.id)),
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
            goBackPage: () => Navigator.pop(context),
          );
        }
        User user = snapshot.data!;
        // "https://avatars.githubusercontent.com/u/77695206?v=4"
        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserPage(
                          user: user,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                          radius: 105,
                          backgroundImage: Image.network(
                                  "https://source.unsplash.com/random/200x200?sig=1",
                                  fit: BoxFit.fill)
                              .image),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              user.username,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            InfoRow(
                              icon: Icons.house_rounded,
                              text: user.company.name,
                              function: null,
                            ),
                            InfoRow(
                              icon: Icons.phone,
                              text: user.phone,
                              function: null,
                            ),
                            InfoRow(
                              icon: Icons.email,
                              text: user.email,
                              function: null,
                            ),
                            InfoRow(
                              icon: Icons.location_on,
                              text:
                                  "${user.address.street}, ${user.address.suite}, ${user.address.suite}, ${user.address.city}, Zip: ${user.address.zipcode}",
                              function: null,
                            ),
                          ],
                        )),
                  ]),
            ),
          ),
        );
      }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InfoRow extends StatelessWidget {
  Function()? function;
  IconData? icon;
  String? text;
  InfoRow({
    Key? key,
    this.function,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Container(
            decoration: (BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white,
                      Colors.blueAccent,
                    ]))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Icon(icon ?? Icons.error),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Flexible(
                    child: Text(
                      text.toString(),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
