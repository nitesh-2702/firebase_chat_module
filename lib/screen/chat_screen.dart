// ignore_for_file: use_build_context_synchronously, must_be_immutable, library_private_types_in_public_api
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_chat_module/models/chat_model.dart';
import 'package:firebase_chat_module/models/receiver_data.dart';
import 'package:firebase_chat_module/providers/chat_provider.dart';
import 'package:firebase_chat_module/repositories/chat_repo.dart';
import 'package:firebase_chat_module/screen/widget/chat_app_bar.dart';
import 'package:firebase_chat_module/screen/widget/chat_container.dart';
import 'package:firebase_chat_module/services/firebase_services.dart';
import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:firebase_chat_module/utils/app_text_style.dart';
import 'package:firebase_chat_module/utils/get_it.dart';
import 'package:firebase_chat_module/utils/sizeconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ReceiverData receiverData;

  ChatScreen({Key? key, required this.receiverData}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String senderId = '';
  File? imageFile;
  bool isMediaUploading = false;
  final ChatProvider _chatProvider = getIt<ChatProvider>();
  String id = "YOmoIoiGkXDiyrzxEB3t";
  String name = "Nitesh";
  ChatRepository chatRepository = ChatRepository();

  final TextEditingController _messageCtrl = TextEditingController();
  MessageData messageData = MessageData();
  // This is the type used by the popup menu below.

  @override
  void initState() {
    super.initState();
    senderId = id;
    initChat();
    getCameraAndOtherPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          decoration: ContainerDecoration.appPrimaryGradient,
          child: Column(
            children: [
              ///Custom App Bar For Chat Screen
              ChatAppBar(
                name: name,
                chatRepository: chatRepository,
                callerId: id,
                receiverId: widget.receiverData.brandId!,
                receiverData: widget.receiverData,
                profileType: "",
              ),
              SizedBox(height: 5),

              ///Chat View Here
              _viewChat(),

              ///Bottom TextField Here (Message Text Field)
              _bottomField(),

              /// Extra Space for Float like Effect
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  ///Chat Stream Here
  Widget _viewChat() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices().getMessageStream(
          chatId: FirebaseServices()
              .getChatRoomId(senderId, widget.receiverData.brandId.toString()),
        ),
        builder: (context, snapshot) {
          ///Entire Chat View Here
          return _chatWidget(snapshot);
        });
  }

  Widget _chatWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data!.docs.isEmpty) {
        return Expanded(
          child: Center(
              child: Text(
            'Start your conversation with Virality',
            style: AppTextStyle.normal10Grey70Mulish400,
          )),
        );
      }
      return Expanded(
          child: ListView.builder(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data?.docs.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          ///Getting the MessageData from database HERE
          ///And putting the data in Message Model
          MessageData messageData = MessageData.fromJson(
              snapshot.data?.docs[index].data() as Map<String, dynamic>);
          return ChatContainer(
            message: messageData.message,
            receivedAt: messageData.sentAt,
            isSent: messageData.senderId == senderId,
            isMedia: messageData.isMedia,
            mediaName: messageData.mediaName,
            avatarUrl: messageData.mediaUrl,
            mediaType: messageData.mediaType,
          );
        },
      ));
    }
    return Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator());
  }

  Widget _bottomField() {
    return Column(
      children: [
        Selector<ChatProvider, XFile?>(
            builder: ((context, value, child) {
              if (value != null) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppColors.blue220,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      context.read<ChatProvider>().fileDetails(value),
                      TextButton(
                        onPressed: () {
                          context.read<ChatProvider>().viewFile(value);
                        },
                        child: const Text(
                          'View Selected File',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      //Todo: Add a Button to deselect the current image
                      IconButton(
                          onPressed: () {
                            context.read<ChatProvider>().deselectFile();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 12,
                          ))
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
            selector: (ctx, provider) => provider.getPickedFile),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                shadowColor: AppColors.black05.withOpacity(0.5),
                child: Container(
                  width: 250,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageCtrl,
                          textAlign: TextAlign.start,
                          enabled: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type something..',
                            hintStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey184),
                          ),
                          onChanged: (text) {
                            messageData = MessageData(
                                senderName: name,
                                senderId: senderId,
                                senderAvatar: "",
                                message: _messageCtrl.text,
                                sentAt: DateTime.now().toUtc());
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.read<ChatProvider>().chatBottomSheet(context);
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(left: 14, right: 12),
                            child: Icon(Icons.attach_file)),
                      ),
                    ],
                  ),
                ),
              ),
              Selector<ChatProvider, XFile?>(
                  builder: ((context, value, child) {
                    return (isMediaUploading)
                        ? const CupertinoActivityIndicator()
                        : InkWell(
                            onTap: () async {
                              if (messageData.message.isNotEmpty &&
                                  messageData.message != '') {
                                _messageCtrl.clear();
                                await FirebaseServices()
                                    .sendMessage(
                                      context: context,
                                      receiverId: widget.receiverData.brandId!,
                                      messageData: messageData,
                                      senderId: senderId,
                                      senderUserName: name,
                                      receiverUserName:
                                          widget.receiverData.brandName!,
                                      senderProfilePic: "",
                                      receiverProfilePic:
                                          widget.receiverData.brandProfilePic!,
                                    )
                                    .then((value) => setState(() {
                                          messageData = MessageData();
                                        }));
                              } else if (value != null) {
                                setState(() {
                                  isMediaUploading = true;
                                  messageData = MessageData();
                                });
                                String? mediaUrl = await context
                                    .read<ChatProvider>()
                                    .uploadImageToAws(
                                        value.path,
                                        senderId,
                                        value.name,
                                        _chatProvider.mediaTypeForUpload);
                                if (mediaUrl != null) {
                                  messageData = MessageData(
                                      senderName: name,
                                      senderId: senderId,
                                      senderAvatar: "",
                                      isMedia: true,
                                      mediaName: context
                                          .read<ChatProvider>()
                                          .customMediaName,
                                      mediaType: context
                                          .read<ChatProvider>()
                                          .mediaType,
                                      mediaUrl: mediaUrl,
                                      sentAt: DateTime.now().toUtc());
                                  await FirebaseServices().sendMessage(
                                    context: context,
                                    receiverId: widget.receiverData.brandId!,
                                    messageData: messageData,
                                    senderId: senderId,
                                    senderUserName: name,
                                    receiverUserName:
                                        widget.receiverData.brandName!,
                                    senderProfilePic: "",
                                    receiverProfilePic:
                                        widget.receiverData.brandProfilePic!,
                                  );
                                  context.read<ChatProvider>().deselectFile();
                                  setState(() {
                                    isMediaUploading = false;
                                    messageData = MessageData();
                                  });
                                } else {
                                  setState(() {
                                    isMediaUploading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: 'Failed to upload attachment');
                                }
                              }
                            },
                            child: Transform.translate(
                              offset: Offset(0, 7),
                              child: Transform.scale(
                                  scale: 1.07, child: const Icon(Icons.send)),
                            ),
                          );
                  }),
                  selector: (ctx, provider) => provider.getPickedFile),
            ],
          ),
        ),
      ],
    );
  }

  // /Gets Chat Message for the very first time
  initChat() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(FirebaseServices()
            .getChatRoomId(senderId, widget.receiverData.brandId!))
        .collection('messages')
        .snapshots()
        .listen((event) {
      // setState(() {});
    });
  }

  void getCameraAndOtherPermissions() async {
    if (await Permission.bluetooth.request().isGranted) {}
    if (await Permission.camera.request().isGranted) {}
    if (await Permission.microphone.request().isGranted) {}
  }
}

class FileList extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const FileList({super.key, required this.files, required this.onOpenedFile});
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Selected Files'),
      ),
      body: ListView.builder(
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];
            return buildFile(file);
          }),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: ListTile(
        leading: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(
                File(file.path.toString()),
                width: 80,
                height: 80,
              )
            : const SizedBox(
                width: 80,
                height: 80,
              ),
        title: Text(file.name),
        subtitle: Text('${file.extension}'),
        trailing: Text(
          size,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
