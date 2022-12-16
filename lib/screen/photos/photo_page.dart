import 'package:flutter/material.dart';
import 'package:flutter_api_call/api/user/model/photo_model.dart';
import 'package:flutter_api_call/screen/error_page.dart';

class PhotoPage extends StatefulWidget {
  final Photo? photo;
  const PhotoPage({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (widget.photo != null) {
          Photo picture = widget.photo!;
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Stack(
              alignment: FractionalOffset.bottomCenter,
              children: [
                Hero(
                  tag: picture.id,
                  child: Image.network(
                    picture.url,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.3),
                  height: 50,
                  child: Text(
                    picture.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ErrorPage(error: "Error while loading the image."),
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
        }
      }),
    );
  }
}
