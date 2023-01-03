import 'dart:ui';

class AppColors {
  // Reds
  static Color guardsmanRed = const Color(0xffb90000);

  // Blues
  static Color marinerBlue = const Color(0xff296ecb);

  // Greys
  static Color romanceWhite = const Color(0xfffefefe);
  static Color lilyWhite = const Color(0xffeaeaea);

  // Blacks
  static Color deepBlack = const Color(0xff000001);
  static Color bunkerBlack = const Color(0xff111214);

  // Greens
  static Color pigmentGreen = const Color(0xff00ba51);
}

class ChartColors {
  static Color bitcoin = const Color(0xfff79319);
}

class ColorFormatter {
  static Color percentage(double value) =>
      value >= 0 ? AppColors.pigmentGreen : AppColors.guardsmanRed;
}

class CryptoColors {
  static Color dollar = const Color.fromARGB(255, 27, 247, 196);

  static final Map<String, Color> _map = {
    "dollar": dollar,
  };

  static Color parse(String symbol) => _map.containsKey(symbol.toLowerCase())
      ? _map[symbol.toLowerCase()]!
      : AppColors.marinerBlue;
}
