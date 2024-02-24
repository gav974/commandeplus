import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


AppBar appbar(title){
  final Color theme_color = Colors.white;



  return AppBar(

    title: Text(title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: theme_color
        ),
      ),
    ),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromRGBO(227, 39, 12, 1),Color.fromRGBO(140, 0, 0, 1)],
      begin: Alignment.topCenter,
      end:Alignment.bottomCenter ,
    ),
    ),
    ),
    titleSpacing: 2,
    bottomOpacity: 0.8,
  );
}

