import 'package:geolocator/geolocator.dart';

class Gps_Healper {
  double latitude = 0;
  double longitude = 0;

  Future<void> get_location() async {
    try {
      Geolocator.requestPermission();
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = pos.latitude;
      longitude = pos.longitude;
    } catch (e) {
      print(e);
    }
  }
}
