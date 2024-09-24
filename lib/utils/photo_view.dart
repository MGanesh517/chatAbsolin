import 'package:chatnew/utils/photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String photo;
  PhotoViewPage({Key? key, required this.photo}) : super(key: key);
  final controller = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                controller.zoomImage();
              },
              child: const Icon(Icons.zoom_in)),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                controller.zoomOutImage();
              },
              child: const Icon(Icons.zoom_out)),
          const SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //     onTap: () async {
          //       try {
          //         // Saved with this method.
          //         var imageId = await ImageDownloader.downloadImage(photo).then((value) async {
          //           var fileName = await ImageDownloader.findName(value!);
          //           Get.snackbar("Image Downloaded", "$fileName",
          //               icon: Icon(Icons.download_done_outlined, color: Theme.of(context).colorScheme.primary),
          //               snackPosition: SnackPosition.BOTTOM,
          //               backgroundColor: Colors.white);
          //         });
          //         if (imageId == null) {
          //           return;
          //         }
          //         // Below is a method of obtaining saved image information.
          //         // var fileName = await ImageDownloader.findName(imageId);
          //         var path = await ImageDownloader.findPath(imageId);
          //         // var size = await ImageDownloader.findByteSize(imageId);
          //         // var mimeType = await ImageDownloader.findMimeType(imageId);
          //         debugPrint("Printing Path: $path");
          //       } on PlatformException catch (error) {
          //         debugPrint(error.toString());
          //       }
          //     },
          //     child: const Icon(Icons.download_rounded)),
          const SizedBox(
            width: 15,
          ),
          // GestureDetector(
          //     onTap: (){
          //       // controller.shareInvoice();
          //     },
          //     child: Icon(Icons.share)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SizedBox(
        child: RepaintBoundary(
          // key: controller.previewinvoice,
          child: Obx(() => PhotoView(
                // enableRotation: true,
                customSize: Size.fromHeight(double.parse(controller.zoomIn.value.toString())),
                controller: PhotoViewController(),
                disableGestures: true,
                enablePanAlways: false,
                imageProvider: NetworkImage(photo),
              )),
        ),
      ),
    );
  }
}
