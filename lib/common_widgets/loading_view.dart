import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class LoadingView extends StatelessWidget {
  final SettingsController _settingsCon = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    final loading =
        loadingWidget(_settingsCon.loadingIcon, _settingsCon.loadingIconColor);
    return Container(
      child: Center(child: loading),
    );
  }

  Widget loadingWidget(String loadingIcon, Color loadingColor) {
    switch (loadingIcon) {
      case 'RotatingPlain':
        return SpinKitRotatingPlain(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'DoubleBounce':
        return SpinKitDoubleBounce(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'Wave':
        return SpinKitWave(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'WanderingCubes':
        return SpinKitWanderingCubes(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'FadingFour':
        return SpinKitFadingFour(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'FadingCube':
        return SpinKitFadingCube(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'Pulse':
        return SpinKitPulse(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'ChasingDots':
        return SpinKitChasingDots(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'ThreeBounce':
        return SpinKitThreeBounce(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'Circle':
        return SpinKitCircle(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'CubeGrid':
        return SpinKitCubeGrid(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'FadingCircle':
        return SpinKitFadingCircle(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'RotatingCircle':
        return SpinKitRotatingCircle(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'FoldingCube':
        return SpinKitFoldingCube(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'PumpingHeart':
        return SpinKitPumpingHeart(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'DualRing':
        return SpinKitDualRing(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'HourGlass':
        return SpinKitHourGlass(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'PouringHourGlass':
        return SpinKitPouringHourglass(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'FadingGrid':
        return SpinKitFadingGrid(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'Ring':
        return SpinKitRing(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'Ripple':
        return SpinKitRipple(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'SpinningCircle':
        return SpinKitSpinningCircle(
          color: loadingColor,
          size: 25,
        );
        break;
      case 'SquareCircle':
        return SpinKitSquareCircle(
          color: loadingColor,
          size: 25,
        );
        break;
      default:
        return SpinKitFadingCircle(
          color: loadingColor,
          size: 25,
        );
        break;
    }
  }
}

class LoadingViewCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitChasingDots(
          color: Color(0xff022c43),
        ),
      ),
    );
  }
}

// class EmptyView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/empty_img.png'),
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }

class ErrorView extends StatelessWidget {
  final String error;

  const ErrorView(this.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/error_image.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: Text(
          error.toString(),
          style:
              Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
