import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/model/photo_model.dart';
import 'package:flutter_api_call/api/user/repository/photo_repository.dart';
import 'package:flutter_api_call/api/user/repository/user_repository.dart';
import 'package:flutter_api_call/screen/error_page.dart';
import 'package:flutter_api_call/screen/photos/photo_page.dart';
import 'package:flutter_api_call/screen/users/add_user_page.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  List<Photo?> photos = [];
  var futureContent = UserRepository.getAllUsers();
  bool searchBoolean = false;
  final _formKey = GlobalKey<FormBuilderState>();

  bool _searchBoolean = false;
  List<Photo?> _searchList = [];
  final TextEditingController _searchTextFieldController =
      TextEditingController();

  String title = "";

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchList = [];
          _searchList = photos
              .where((mapObject) =>
                  (mapObject!.title).toLowerCase().contains(s.toLowerCase()))
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
    return gridViewBuilder(list: _searchList);
  }

  Widget _defaultListView() {
    return gridViewBuilder(list: photos);
  }

  GridView gridViewBuilder({required List<Photo?> list}) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotoPage(
                        photo: list[index],
                      ),
                  fullscreenDialog: true),
            );
          },
          child: Hero(
            tag: list[index]!.id.toString(),
            child: Card(
              child: Stack(
                alignment: FractionalOffset.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(list[index]!.thumbnailUrl),
                          fit: BoxFit.cover),
                    ),
                    // child: Image.network(photos[index]!.url),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    color: Colors.black.withOpacity(0.3),
                    child: Text(
                      list[index]!.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
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
        title: !_searchBoolean ? const Text("Photos list") : _searchTextField(),
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
        child: StreamBuilder<List<Photo?>>(
          stream: Stream.fromFuture(PhotoRepository.getAllphotos()),
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
              photos = snapshot.data!;
              return !_searchBoolean ? _defaultListView() : _searchListView();
            }
          },
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
