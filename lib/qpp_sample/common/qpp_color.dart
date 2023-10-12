import 'dart:ui';

/// 顏色取用
enum QppColor {
  /// qpp basic website palette
  white,

  /// qpp basic website palette
  spiroDiscoBall,

  /// qpp basic website palette
  manatee,

  /// qpp basic website palette
  oliveDrab,

  /// qpp basic website palette
  laserLemon,

  /// qpp basic website palette
  yaleBlue,

  /// qpp basic website palette
  onyx,

  /// onyx color with opacity 80%
  onyx80,

  /// onyx color with opacity 60%
  onyx60,
}

extension QppColorExtension on QppColor {
  Color get color {
    switch (this) {
      case QppColor.white:
        return const Color(0xFFFFFFFF);
      case QppColor.spiroDiscoBall:
        return const Color(0xFF22B9FF);
      case QppColor.manatee:
        return const Color(0xFF959595);
      case QppColor.oliveDrab:
        return const Color(0xFF313131);
      case QppColor.laserLemon:
        return const Color(0xFFFDEB1E);
      case QppColor.onyx:
        return const Color(0xFF000B2B);
      case QppColor.onyx80:
        return (QppColor.onyx.color).withOpacity(0.8);
      case QppColor.onyx60:
        return (QppColor.onyx.color).withOpacity(0.6);
      case QppColor.yaleBlue:
      default:
        return const Color(0xFF1E4287);
    }
  }
}

// Opacity(不透明度) of the color
// 100% - FF
// 95% - F2
// 90% - E6
// 85% - D9
// 80% - CC
// 75% - BF
// 70% - B3
// 65% - A6
// 60% - 99
// 55% - 8C
// 50% - 80
// 45% - 73
// 40% - 66
// 35% - 59
// 30% - 4D
// 25% - 40
// 20% - 33
// 15% - 26
// 10% - 1A
// 5% - 0D
// 0% - 00
