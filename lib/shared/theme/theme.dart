import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006b5e),
      surfaceTint: Color(0xff006b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9ff2e1),
      onPrimaryContainer: Color(0xff005046),
      secondary: Color(0xff4a635e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcde8e1),
      onSecondaryContainer: Color(0xff334b46),
      tertiary: Color(0xff3b6939),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcf0b4),
      onTertiaryContainer: Color(0xff235024),
      error: Color(0xff904a44),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff73332e),
      surface: Color(0xfff4fbf8),
      onSurface: Color(0xff171d1b),
      onSurfaceVariant: Color(0xff3f4946),
      outline: Color(0xff6f7976),
      outlineVariant: Color(0xffbec9c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inversePrimary: Color(0xff83d5c5),
      primaryFixed: Color(0xff9ff2e1),
      onPrimaryFixed: Color(0xff00201b),
      primaryFixedDim: Color(0xff83d5c5),
      onPrimaryFixedVariant: Color(0xff005046),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff06201b),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff334b46),
      tertiaryFixed: Color(0xffbcf0b4),
      onTertiaryFixed: Color(0xff002204),
      tertiaryFixedDim: Color(0xffa1d39a),
      onTertiaryFixedVariant: Color(0xff235024),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff4fbf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f2),
      surfaceContainer: Color(0xffe9efec),
      surfaceContainerHigh: Color(0xffe3eae7),
      surfaceContainerHighest: Color(0xffdee4e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003e36),
      surfaceTint: Color(0xff006b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff207a6c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff223b36),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff59726c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff113f15),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4a7847),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e231f),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa15851),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf8),
      onSurface: Color(0xff0c1211),
      onSurfaceVariant: Color(0xff2f3836),
      outline: Color(0xff4b5552),
      outlineVariant: Color(0xff656f6c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inversePrimary: Color(0xff83d5c5),
      primaryFixed: Color(0xff207a6c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006054),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff59726c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff415a54),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4a7847),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff325f31),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c5),
      surfaceBright: Color(0xfff4fbf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f2),
      surfaceContainer: Color(0xffe3eae7),
      surfaceContainerHigh: Color(0xffd8dedb),
      surfaceContainerHighest: Color(0xffcdd3d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00332c),
      surfaceTint: Color(0xff006b5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005349),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff18302c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff354e49),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff04340b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff265326),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511a16),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff763630),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e2c),
      outlineVariant: Color(0xff414b49),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3230),
      inversePrimary: Color(0xff83d5c5),
      primaryFixed: Color(0xff005349),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003a32),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff354e49),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1f3732),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff265326),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0d3b11),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab7),
      surfaceBright: Color(0xfff4fbf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2ef),
      surfaceContainer: Color(0xffdee4e1),
      surfaceContainerHigh: Color(0xffcfd6d3),
      surfaceContainerHighest: Color(0xffc1c8c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff83d5c5),
      surfaceTint: Color(0xff83d5c5),
      onPrimary: Color(0xff003730),
      primaryContainer: Color(0xff005046),
      onPrimaryContainer: Color(0xff9ff2e1),
      secondary: Color(0xffb1ccc5),
      onSecondary: Color(0xff1c3530),
      secondaryContainer: Color(0xff334b46),
      onSecondaryContainer: Color(0xffcde8e1),
      tertiary: Color(0xffa1d39a),
      onTertiary: Color(0xff0a390f),
      tertiaryContainer: Color(0xff235024),
      onTertiaryContainer: Color(0xffbcf0b4),
      error: Color(0xffffb4ac),
      onError: Color(0xff561e1a),
      errorContainer: Color(0xff73332e),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffdee4e1),
      onSurfaceVariant: Color(0xffbec9c5),
      outline: Color(0xff899390),
      outlineVariant: Color(0xff3f4946),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e1),
      inversePrimary: Color(0xff006b5e),
      primaryFixed: Color(0xff9ff2e1),
      onPrimaryFixed: Color(0xff00201b),
      primaryFixedDim: Color(0xff83d5c5),
      onPrimaryFixedVariant: Color(0xff005046),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff06201b),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff334b46),
      tertiaryFixed: Color(0xffbcf0b4),
      onTertiaryFixed: Color(0xff002204),
      tertiaryFixedDim: Color(0xffa1d39a),
      onTertiaryFixedVariant: Color(0xff235024),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b39),
      surfaceContainerLowest: Color(0xff090f0e),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff99ecdb),
      surfaceTint: Color(0xff83d5c5),
      onPrimary: Color(0xff002b25),
      primaryContainer: Color(0xff4b9e90),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc7e2db),
      onSecondary: Color(0xff112a25),
      secondaryContainer: Color(0xff7c9690),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb6eaae),
      onTertiary: Color(0xff002d06),
      tertiaryContainer: Color(0xff6c9c68),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cd),
      onError: Color(0xff481310),
      errorContainer: Color(0xffcc7b73),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dfdb),
      outline: Color(0xffaab4b1),
      outlineVariant: Color(0xff88928f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e1),
      inversePrimary: Color(0xff005247),
      primaryFixed: Color(0xff9ff2e1),
      onPrimaryFixed: Color(0xff001511),
      primaryFixedDim: Color(0xff83d5c5),
      onPrimaryFixedVariant: Color(0xff003e36),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff001511),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff223b36),
      tertiaryFixed: Color(0xffbcf0b4),
      onTertiaryFixed: Color(0xff001602),
      tertiaryFixedDim: Color(0xffa1d39a),
      onTertiaryFixedVariant: Color(0xff113f15),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff3f4644),
      surfaceContainerLowest: Color(0xff040807),
      surfaceContainerLow: Color(0xff191f1d),
      surfaceContainer: Color(0xff232927),
      surfaceContainerHigh: Color(0xff2d3432),
      surfaceContainerHighest: Color(0xff383f3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb0ffef),
      surfaceTint: Color(0xff83d5c5),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7fd1c1),
      onPrimaryContainer: Color(0xff000e0b),
      secondary: Color(0xffdaf6ee),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffadc8c1),
      onSecondaryContainer: Color(0xff000e0b),
      tertiary: Color(0xffc9fec1),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9dcf96),
      onTertiaryContainer: Color(0xff000f01),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea5),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2ee),
      outlineVariant: Color(0xffbbc5c1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e1),
      inversePrimary: Color(0xff005247),
      primaryFixed: Color(0xff9ff2e1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff83d5c5),
      onPrimaryFixedVariant: Color(0xff001511),
      secondaryFixed: Color(0xffcde8e1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb1ccc5),
      onSecondaryFixedVariant: Color(0xff001511),
      tertiaryFixed: Color(0xffbcf0b4),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa1d39a),
      onTertiaryFixedVariant: Color(0xff001602),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff4b514f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b211f),
      surfaceContainer: Color(0xff2b3230),
      surfaceContainerHigh: Color(0xff363d3b),
      surfaceContainerHighest: Color(0xff424846),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
