
import 'package:firebase_chat_module/models/chat_model.dart';
import 'package:firebase_chat_module/services/helper_function.dart';
import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:firebase_chat_module/utils/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';

class ChatProvider with ChangeNotifier {
  static const String _image = 'Image';
  static const String _camera = 'Camera';
  static const String _video = 'Video';
  static const String _document = 'Document';

  String mediaType = 'All';
  String mediaTypeForUpload = 'image';
  XFile? _pickedFile;
  String customMediaName = '';

  XFile? get getPickedFile => _pickedFile;
  String get getCustomMediaName => customMediaName;
  set setPickedFile(XFile? file) => _pickedFile;
  MessageData messageData = MessageData();

  String customMediaNameGenerator() {
    DateTime datetime = DateTime.now();
    String year = datetime.year.toString();
    String month = datetime.month.toString();
    String day = datetime.day.toString();
    String hour = datetime.hour.toString();
    String minute = datetime.minute.toString();
    String second = datetime.second.toString();
    customMediaName = 'ViralityMedia_$year$month$day$hour$minute$second';
    return customMediaName;
  }

  Widget fileDetails(XFile? file) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customMediaNameGenerator(),
            style: const TextStyle(
              fontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void pickFiles(String filetype, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    switch (filetype) {
      case _image:
        _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        mediaType = 'Image';
        mediaTypeForUpload = 'image';
        Navigator.pop(context);
        notifyListeners();
        break;
      case _camera:
        _pickedFile = await _picker.pickImage(source: ImageSource.camera);
        mediaType = 'Image';
        mediaTypeForUpload = 'image';
        Navigator.pop(context);
        notifyListeners();
        break;
      case _video:
        _pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
        mediaType = 'Video';
        mediaTypeForUpload = 'video';
        Navigator.pop(context);
        notifyListeners();
        break;
    }
  }

  ///Returns Number of Days Between 2 Dates
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future uploadImageToAws(
      String imagePath, String userId, String fileName, String mediaType) {
    return HelperFunction.uploadSingleImageFileChat(
        imagePath, userId, fileName, mediaType);
  }

  void deselectFile() {
    _pickedFile = null;
    notifyListeners();
  }

  // open the picked file
  void viewFile(XFile? file) {
    OpenFilex.open(file!.path);
  }

  chatBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      backgroundColor: AppColors.whiteFF,
      context: context,
      builder: (context) => Container(
        margin: const EdgeInsets.all(30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () async {
              pickFiles(_camera, context);
            },
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.red212,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.camera_alt, color: AppColors.whiteFFF),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Select From Camera",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              pickFiles(_image, context);
            },
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.blue77,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.photo, color: AppColors.whiteFFF),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Select Image",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              pickFiles(_video, context);
            },
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.blue77,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.video_collection_outlined,
                      color: AppColors.whiteFFF),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Select Video",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
          ),

          ///Todo: Add Select Document TYPE
          // SizedBox(height: 20),
          // GestureDetector(
          //   onTap: () async {
          //     pickFiles(_document,context);
          //   },
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 40 * SizeConfig.heightMultiplier,
          //         width: 40 * SizeConfig.widthMultiplier,
          //         decoration: BoxDecoration(
          //             color: AppColors.blue77,
          //             borderRadius: BorderRadius.circular(20)),
          //         child: Icon(Icons.video_collection_outlined, color: AppColors.whiteFFF),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "Select Document",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          //       )
          //     ],
          //   ),
          // ),
        ]),
      ),
    );
  }
}
