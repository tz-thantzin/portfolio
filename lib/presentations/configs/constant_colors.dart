import 'package:flutter/material.dart';

const Color kPrimary = Color(0xFF242439);
const Color kSecondary = Colors.deepPurple;
const Color kWhite = Colors.white;
const Color kWhite70 = Colors.white70;
const Color kBlack = Colors.black;
const Color kBlack100 = Color(0xFF303030);
const Color kBlueAccent = Colors.blueAccent;
final Color kBlue = Colors.blueAccent.shade200;
const Color kTransparent = Colors.transparent;

const Color kIndigo = Colors.indigo;
const Color kDeepPurple = Colors.deepPurple;
const Color kRed = Colors.red;
const Color kGreen = Colors.green;
final Color kRed100 = Colors.red.shade100;
const Color kTomato = Color(0xFFFA523C);

const Color kFooterBg = Color(0xFF363e57);

// Gradients
const LinearGradient kTomatoGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFFA523C), // Tomato base
    Color(0xFFFF7B5C), // Lighter shade
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kAmberGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFFFC107), // Amber Yellow base
    Color(0xFFFFE082), // Light Amber
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kOrangeGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFFF9800), // Deep Orange
    Color(0xFFFFB74D), // Light Orange
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kSoftTealGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFE0F7FA), // Light teal
    Color(0xFFB2EBF2), // Soft aqua
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

// ===== support colors =====
const Color kGrey25 = Color(0xFFFCFCFC); //Grey/25 | #FCFCFC
const Color kGrey100 = Color(0xFFF2F2F2); //Grey/100 | #F2F2F2
const Color kGrey200 = Color(0xFFE0E0E0); //Grey/200 | #E0E0E0
const Color kGrey300 = Color(0xFFCECECE); //Grey/300 | #CECECE
const Color kGrey400 = Color(0xFFBCBCBC); //Grey/400 | #BCBCBC
const Color kGrey500 = Color(0xFFABABAB); //Grey/500 | #ABABAB
const Color kGrey700 = Color(0xFF878787); //Grey/700 | #878787
const Color kGrey800 = Color(0xFF6B6B6B); //Grey/800 | #6B6B6B
const Color kGrey900 = Color(0xFF5E5E5E); //Grey/900 | #5E5E5E
const Color kGrey1000 = Color(0xFF515151); //Grey/1000 | #515151
const Color kGrey1200 = Color(0xFF2E2E2E); //Grey/1200 | #2E2E2E
