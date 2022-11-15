// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_chat_module/screen/widget/attachment_view.dart';
import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:firebase_chat_module/utils/sizeconfig.dart';
import 'package:firebase_chat_module/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatContainer extends StatefulWidget {
  const ChatContainer({super.key, 
    this.isSent = true,
    this.message,
    this.mediaSize,
    this.mediaName,
    this.isMedia = false,
    this.avatarUrl,
    this.receivedAt,
    this.mediaType,
  });

  final bool isSent;
  final String? message;
  final int? mediaSize;
  final bool? isMedia;
  final String? mediaName;
  final String? avatarUrl;
  final DateTime? receivedAt;
  final String? mediaType;

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment:
              widget.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: widget.isSent
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: widget.isSent
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.isSent) const SizedBox(width: 6),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                           widget.isSent
                              ? AppColors.blue220
                              : AppColors.red252,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomRight: widget.isSent
                            ? Radius.zero
                            : const Radius.circular(15),
                        bottomLeft: widget.isSent
                            ? const Radius.circular(15)
                            : Radius.zero,
                      ),
                    ),
                    child: (widget.isMedia!)
                        ? InkWell(
                            onTap: () async {
                              if(widget.mediaType != 'Image') {
                                final Uri url = Uri.parse(widget.avatarUrl!);
                                _launchInBrowser(url);
                              }
                              else{
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AttachmentView(src: widget.avatarUrl!)));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _openNetworkFile(filePath: widget.avatarUrl,fileType: widget.mediaType!)!,
                                  SizedBox(height: 4),
                                  Text(
                                    Utilities().dateTimeConvertor(
                                        date: widget.receivedAt!, onlyTime: true),
                                    // widget.receivedAt!.toLocal().toString(),
                                    style: const TextStyle(
                                      color: AppColors.grey77,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 274 ),
                                child: Text(
                                  widget.message!,
                                ),
                              ),
                              SizedBox(height: 4 ),
                              // if (widget.receivedAt != 0)
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 274 ),
                                child: Text(
                                  Utilities().dateTimeConvertor(
                                      date: widget.receivedAt!, onlyTime: true),
                                  // widget.receivedAt!.toLocal().toString(),
                                  style: const TextStyle(
                                    color: AppColors.grey77,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                if (widget.isSent) const SizedBox(width: 6),
              ],
            ),
            SizedBox(height: 23 ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget? _openNetworkFile({required String fileType, var filePath}){
    switch (fileType) {
      case 'Image':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image,color: AppColors.blue4E,),
            const SizedBox(width: 10),
            Text(
              widget.mediaName ?? " ",
              style: const TextStyle(color: AppColors.blue4E),
            ),
          ],
        );
      case 'Video':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.slow_motion_video_outlined,color: AppColors.blue4E,),
            const SizedBox(width: 10),
            Text(
              widget.mediaName ?? " ",
              style: const TextStyle(color: AppColors.blue4E),
            ),
          ],
        );
        case 'Document':
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.file_copy,color: AppColors.blue4E,),
          const SizedBox(width: 10),
          Text(
            widget.mediaName ?? " ",
            style: const TextStyle(color: AppColors.blue4E),
          ),
        ],
      );

    }
    return null;
  }
}



