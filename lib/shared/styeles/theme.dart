import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial/shared/styeles/color.dart';
ThemeData lightTheme =  ThemeData(

  fontFamily: 'Marhey',
  primarySwatch: defaultColor,



  scaffoldBackgroundColor: defaultColor[50],



  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,



    systemOverlayStyle: SystemUiOverlayStyle(



      statusBarColor: defaultColor[50],



      statusBarIconBrightness: Brightness.dark,



    ),



    backgroundColor: defaultColor[50],



    elevation: 0.0,



    titleTextStyle: const TextStyle(


      color: defaultColor,



      fontWeight: FontWeight.bold,



      fontSize: 20.0,



    ),



    iconTheme: const IconThemeData(



      color:defaultColor,



    ),



  ),



  bottomNavigationBarTheme: const BottomNavigationBarThemeData(



    type: BottomNavigationBarType.fixed,



    selectedItemColor: defaultColor,



    elevation: 20.0,



    backgroundColor: Colors.white,



  ),



  textTheme: const TextTheme(



    bodyText1: TextStyle(
      fontFamily: 'Marhey',


      fontSize:18.0,



      fontWeight: FontWeight.w600,



      color: defaultColor,



    ),
subtitle1: TextStyle(
  fontFamily: 'Marhey',
  fontSize:14.0,

height: 1.3,

  fontWeight: FontWeight.w600,



  color: defaultColor,
),


  ),







);