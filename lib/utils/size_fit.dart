import 'dart:ui';

class SizeFit {
  // 1.基本信息
  static double? physicalWidth;
  static double? physicalHeight;
  static double? screenWidth;
  static double? screenHeight;
  static double? dpr;
  static double? statusHeight;

  static double? rpx;
  static double? px;

  static void initialize({double standardSize = 750}) {
    // 1.手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    // 2.获取dpr
    dpr = window.devicePixelRatio;

    // 3.宽度和高度
    screenWidth = (physicalWidth! / dpr!);
    screenHeight = physicalHeight! / dpr!;

    // 4.状态栏高度
    statusHeight = window.padding.top / dpr!;

    // 5.计算rpx的大小
    rpx = screenWidth! / standardSize;
    px = screenWidth! / standardSize * 2;
  }

  static double setRpx(double size) {
    return rpx! * size;
  }

  static double setPx(double size) {
    return px! * size;
  }
}

extension IntFit on int {
  double get px {
    return SizeFit.setPx(toDouble());
  }

  double get rpx {
    return SizeFit.setRpx(toDouble());
  }
}

extension DoubleFit on double {
  double get px {
    return SizeFit.setPx(this);
  }

  double get rpx {
    return SizeFit.setRpx(this);
  }
}
