// import 'dart:html';  // For accessing browser's local storage

// import 'package:uuid/uuid.dart';

// class DeviceId {
//   static String getDeviceId() {
//     const storageKey = 'device_id';
//     var deviceId = window.localStorage[storageKey];

//     if (deviceId == null) {
//       // Generate a new UUID
//       var uuid = const Uuid();
//       deviceId = uuid.v4();

//       // Store it in local storage
//       window.localStorage[storageKey] = deviceId;
//     }

//     return deviceId;
//   }
// }