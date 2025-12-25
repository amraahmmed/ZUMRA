import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static final TextStyle headline = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static final TextStyle subHead = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle inputLabel = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle text = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle small = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static final TextStyle mini = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
  
  // Poppins SemiBold - 14
  static final TextStyle large = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
    color: Colors.black,
  );
}