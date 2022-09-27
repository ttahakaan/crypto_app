import 'package:crypto_app_1/product/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'crypto_view.dart';

// ignore: must_be_immutable
class MenuView extends StatelessWidget {
  MenuView({Key? key}) : super(key: key);
  bool isloading = true;

  final bool _iconBool = true;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.bedtime;

  var snackBar = SnackBar(
    content: const Text(
      'Merhaba Uygulamaya Hoşgeldiniz.',
      style: TextStyle(fontSize: 25),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.amber[700],
    padding: const EdgeInsets.all(16),
    // ignore: avoid_print
    onVisible: () => print(' '),
    elevation: 12,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    dismissDirection: DismissDirection.vertical,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Workshop"))),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Icon(Icons.archive)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CryptoView()),
                    );
                  },
                  child: const Icon(Icons.arrow_forward)),
              ElevatedButton(
                  onPressed: () =>
                      {context.read<ThemeNotifier>().changeTheme()},
                  child: Icon(_iconBool ? _iconDark : _iconLight)),
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
