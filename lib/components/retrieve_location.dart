import 'package:flutter/services.dart';
import 'package:location/location.dart';

// The below retrieveLocation function was adapted from
// the CS492 Exploration: Platform Hardware Services
// Date Retrieved: 28-Feb-2022

dynamic retrieveLocation() async {
  LocationData? locationData;
  var locationService = Location();

  try {
    var _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        print('Failed to enable service. Returning.');
        return;
      }
    }

    var _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location service permission not granted. Returning.');
      }
    }

    locationData = await locationService.getLocation();
  } on PlatformException catch (e) {
    print('Error: ${e.toString()}, code: ${e.code}');
    locationData = null;
  }
  locationData = await locationService.getLocation();

  return locationData;
}
