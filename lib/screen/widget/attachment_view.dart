import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:flutter/material.dart';


class AttachmentView extends StatelessWidget {
  String src;

  AttachmentView({Key? key, required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '$src view',
      child: Material(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.network(
                src,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
