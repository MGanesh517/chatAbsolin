import 'package:get/get.dart';

class PhotoController extends GetxController {
  static PhotoController get to => Get.find();

  RxInt zoomIn = 400.obs;
  zoomImage() {
    if (zoomIn.value == 400) {
      zoomIn.value = 500;
    } else if (zoomIn.value == 500) {
      zoomIn.value = 600;
    }
  }

  zoomOutImage() {
    if (zoomIn.value == 600) {
      zoomIn.value = 500;
    } else if (zoomIn.value == 500) {
      zoomIn.value = 400;
    }
  }
}



// var data = {
//   "transferstatus": 2
// };
