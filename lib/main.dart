 import 'package:flutter/material.dart';
import 'package:tutorial/homeScreen.dart';
import 'package:tutorial/shared/styeles/theme.dart';
import 'package:tutorial/test.dart';
 void main() {
   runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme:lightTheme,
       home:Directionality(
           textDirection: TextDirection.rtl,
           child: AzLayoutScreen())
     );
   }
 }
