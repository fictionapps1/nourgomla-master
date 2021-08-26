import 'package:flutter/material.dart';
enum LogoAnimations {
  scale,
  fade,
  shake,
}
enum TextAnimations {
  blink,
  typeWriting,
  colorize,
}

class LocalConfig {
  static const Color _splashBgColor = Color(0xFF004389);
  static const Color _splashTextColor = Color(0xFFd29c60);

  static Color get splashTextColor => _splashTextColor;
  static const String _splashText = 'نور جملة';

  static const String _mapsApiKey = '';
  static const int _appVersion= 1;

  static LogoAnimations _splashLogoAnimation = LogoAnimations.scale;
  static TextAnimations _splashTextAnimation = TextAnimations.blink;
  static String get splashText => _splashText;
  static int get appVersion => _appVersion;

  static String get mapsApiKey => _mapsApiKey;

  static Color get splashBgColor => _splashBgColor;

  static LogoAnimations get splashLogoAnimation => _splashLogoAnimation;

  static TextAnimations get splashTextAnimation => _splashTextAnimation;

}
