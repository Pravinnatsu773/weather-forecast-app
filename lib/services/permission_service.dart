import 'package:app_settings/app_settings.dart';
import 'package:location/location.dart';
import 'package:weather_forcast_task/utils/helper.dart';

class PermissionService {
  Future<bool> getPermission() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (permissionGranted == PermissionStatus.deniedForever) {
          await AppSettings.openAppSettings();
        }
        return false;
      }
    }

    return true;
  }
}
