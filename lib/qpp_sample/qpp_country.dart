enum QppCountry {
  traditionalChinese,
  simplifiedChinese,
  english,
  japanese,
  korean,
  vietnam,
  thailand,
  indonesia;
}

extension CountryExtension on QppCountry {
  String get buttonTitle {
    switch (this) {
      case QppCountry.traditionalChinese:
        return "繁體中文";
      case QppCountry.simplifiedChinese:
        return "中文(简体)";
      case QppCountry.english:
        return "English";
      case QppCountry.japanese:
        return "日本語";
      case QppCountry.korean:
        return "한국어";
      case QppCountry.vietnam:
        return "Việt Nam";
      case QppCountry.thailand:
        return "ภาษาไทย";
      case QppCountry.indonesia:
        return "Bahasa Indonesia";
      default:
        return "";
    }
  }

  int get index {
    switch (this) {
      case QppCountry.traditionalChinese:
        return 0;
      case QppCountry.simplifiedChinese:
        return 1;
      case QppCountry.english:
        return 2;
      case QppCountry.japanese:
        return 3;
      case QppCountry.korean:
        return 4;
      case QppCountry.vietnam:
        return 5;
      case QppCountry.thailand:
        return 6;
      case QppCountry.indonesia:
        return 7;
      default:
        return -1;
    }
  }

  int get size {
    return 8;
  }

  // int get value {
  //   switch (this) {
  //     case BlueShade.blue100:
  //       return 100;
  //     case BlueShade.blue200:
  //       return 200;
  //     case BlueShade.blue300:
  //       return 300;
  //     case BlueShade.blue400:
  //       return 400;
  //     case BlueShade.blue500:
  //       return 500;
  //     case BlueShade.blue600:
  //       return 600;
  //     case BlueShade.blue700:
  //       return 700;
  //     default:
  //       return 500;
  //   }
  // }
}
