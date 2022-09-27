import 'package:crypto_app_1/product/theme_notifier.dart';
import 'package:crypto_app_1/view/deneme.dart';
import 'package:crypto_app_1/view/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => ThemeNotifier()),
          
    ],
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<ThemeNotifier>().currentTheme,
      home: MenuView(),
    );
  }
}
