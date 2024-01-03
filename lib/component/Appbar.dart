import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appbar(title){
  return AppBar(
    title: Text(title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
    
    leadingWidth: 25,
    toolbarHeight: 80.00,
    backgroundColor: Colors.red.shade900,
    centerTitle: true,
    bottomOpacity: 0.1,
    toolbarOpacity:0.5 ,
  );
}