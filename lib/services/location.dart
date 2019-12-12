
import 'package:geolocator/geolocator.dart';

class LocationData {

  double latitude, longitude;

  void getCurrentLocation() async {

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}