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

const LinearGradient kPurplePinkGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF8E24AA), // Deep Purple
    Color(0xFFFF4081), // Pink
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kElectricBlueGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF2979FF), // Bright Blue
    Color(0xFF00E5FF), // Cyan
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kLimeGreenGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF00E676), // Bright Green
    Color(0xFFB2FF59), // Light Lime
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final List<LinearGradient> kProjectCardGradients = [
  kTomatoGradient,
  kAmberGradient,
  kOrangeGradient,
  kPurplePinkGradient,
  kElectricBlueGradient,
  kLimeGreenGradient,
];
// ===== TEXT COLORS PROJECT ======

final List<Color> kProjectTextColor = [
  Color(0xFF000080),
  Color(0xFF0D47A1),
  Color(0xFF2F4F4F),
  Color(0xFFFFD700),
  Color(0xFFFF4500),
  Color(0xFFC71585),
];

const LinearGradient kTealGreenTextGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF008080), // Teal
    Color(0xFF4CBB17), // Green
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kTextTomatoGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFFFFFFF), // White for contrast
    Color(0xFFFFF176), // Soft yellow accent
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kTextAmberGradient = LinearGradient(
  colors: <Color>[
    Color(0xFFD32F2F), // Dark red
    Color(0xFF7B1FA2), // Deep purple
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient kTextOrangeGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF0D47A1), // Dark Blue
    Color(0xFF00BCD4), // Cyan
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
