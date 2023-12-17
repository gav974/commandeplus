import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appbar(title){
  return AppBar(
    toolbarHeight: 50.00,
    backgroundColor: Colors.red.shade900,
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
    centerTitle: true,
  );
}