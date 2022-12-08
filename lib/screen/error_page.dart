import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  var error;
  Function()? goBackPage;

  ErrorPage({
    Key? key,
    required this.error,
    this.goBackPage,
  }) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.error.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    if (widget.goBackPage != null)
                      TextButton(
                        onPressed: widget.goBackPage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Close"),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.close_outlined),
                          ],
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
