import 'package:flutter/material.dart';

class Deneme extends StatelessWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("App Bar Örneği"),
    ),
    body: Text("Hello World!"),
    );
  }
}
