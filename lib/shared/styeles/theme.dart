import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutorial/shared/styeles/color.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,



    backwardsCompatibility: false,



    systemOverlayStyle: SystemUiOverlayStyle(



      statusBarColor: HexColor('333739'),



      statusBarIconBrightness: Brightness.light,



    ),



    backgroundColor:HexColor('333739'),



    elevation: 0.0,



    titleTextStyle: TextStyle(



      color: Colors.white,



      fontWeight: FontWeight.bold,



      fontSize: 20.0,



    ),



    iconTheme: IconThemeData(



      color: Colors.white,



    ),



  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(



    type: BottomNavigationBarType.fixed,



    selectedItemColor: defaultColor,



    unselectedItemColor: Colors.grey,



    elevation: 20.0,



    backgroundColor:Colors.black,



  ),



  textTheme: TextTheme(



    bodyText1: TextStyle(



      fontSize:18.0,



      fontWeight: FontWeight.w600,



      color: Colors.white,



    ),
    subtitle1: TextStyle(
height: 1.3,
      fontSize:14.0,



      fontWeight: FontWeight.w600,



      color: Colors.white,
    )



  ),



);
ThemeData lightTheme =  ThemeData(



  primarySwatch: defaultColor,



  scaffoldBackgroundColor: Colors.brown[50],



  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,



    backwardsCompatibility: false,



    systemOverlayStyle: SystemUiOverlayStyle(



      statusBarColor: Colors.brown[50],



      statusBarIconBrightness: Brightness.dark,



    ),



    backgroundColor: Colors.brown[50],



    elevation: 0.0,



    titleTextStyle: TextStyle(


      color: Colors.black,



      fontWeight: FontWeight.bold,



      fontSize: 20.0,



    ),



    iconTheme: IconThemeData(



      color: Colors.black,



    ),



  ),



  bottomNavigationBarTheme: BottomNavigationBarThemeData(



    type: BottomNavigationBarType.fixed,



    selectedItemColor: defaultColor,



    elevation: 20.0,



    backgroundColor: Colors.white,



  ),



  textTheme: TextTheme(



    bodyText1: TextStyle(



      fontSize:18.0,



      fontWeight: FontWeight.w600,



      color: Colors.black,



    ),
subtitle1: TextStyle(

  fontSize:14.0,

height: 1.3,

  fontWeight: FontWeight.w600,



  color: Colors.black,
),


  ),







);