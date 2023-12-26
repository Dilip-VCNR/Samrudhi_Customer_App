import 'package:geolocator/geolocator.dart';

class AuthController {
  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }

  bool isNotValidName(String name) {
    // Regular expression pattern to validate name format
    const nameRegex = r'^[a-zA-Z\s]+$';

    // Use RegExp to check if the name matches the pattern
    final regExp = RegExp(nameRegex);
    if (!regExp.hasMatch(name)) {
      return true;
    }

    // Check if the name contains any numbers
    final containsNumbers = name.contains(RegExp(r'[0-9]'));
    return containsNumbers;
  }

  bool isNotValidPhone(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return true;
    }
    if (phoneNumber.length != 10 || !isNumeric(phoneNumber)) {
      return true;
    }
    return false;
  }

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }


  bool? serviceEnabled;
  LocationPermission? permission;

  Future<Position> getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }
}
