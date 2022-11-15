import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_module/models/chat_model.dart';
import 'package:firebase_chat_module/models/receiver_data.dart';
import 'package:firebase_chat_module/screen/chat_screen.dart';
import 'package:firebase_chat_module/services/firebase_services.dart';
import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:firebase_chat_module/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  String senderId = '';
  String receiverId = '';
  String id = "YOmoIoiGkXDiyrzxEB3t", name = "";
  final List<Map<String, dynamic>> _userListMap = [];
  List<ReceiverData> receiverData = [];

  @override
  void initState() {
    senderId = id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteFF,
        body: SafeArea(
            child: Container(
          decoration: ContainerDecoration.appPrimaryGradient,
          child: Column(
            children: [
              ///Custom App Bar For Message Screen
              Row(
                children: const [
                  Text(
                    'Messages',
                  ),
                ],
              ),

              ///Search Controller Starts Here
              Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(-1, 1),
                            blurRadius: 3,
                            color: AppColors.grey229)
                      ]),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        // borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      labelText: 'Search',
                    ),
                  )),

              ///Message Tiles Starts Here
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices().getMessageList(senderId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.size == 0) {
                        return Expanded(
                            child: Center(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'No Messages Here',
                              // style: AppTextStyle.normal10Grey70Mulish400,
                            ),
                          ],
                        )));
                      }
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            getReceiverData(index, snapshot);
                            
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            receiverData: receiverData[index]),
                                      ));
                                },
                                child:
                                    _messageTile(index, receiverData[index]));
                          }),
                        ),
                      );
                    } else {
                      return Expanded(
                          child: Center(
                              child: (Platform.isAndroid)
                                  ? const CircularProgressIndicator()
                                  : const CupertinoActivityIndicator()));
                    }
                  }),
            ],
          ),
        )),

        ///Todo: Add functionality to the Button when provided !!!
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   backgroundColor: AppColors.primary,
        //   onPressed: () {},
        // ),
      ),
    );
  }

  void getReceiverData(
      int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    
    _userListMap.add(snapshot.data?.docs[index].data() as Map<String, dynamic>);
    if (_userListMap[index]['userID'][0] == id) {
      receiverData.add(ReceiverData(
        brandId: _userListMap[index]['userID'][1],
        brandName: _userListMap[index]['userList'][1]['name'],
        brandProfilePic: _userListMap[index]['userList'][1]['profilePic'],
      ));
      receiverId = _userListMap[index]['userID'][1];
    } else {
      receiverData.add(ReceiverData(
        brandId: _userListMap[index]['userID'][0],
        brandName: _userListMap[index]['userList'][0]['name'],
        brandProfilePic: _userListMap[index]['userList'][0]['profilePic'],
      ));
      receiverId = _userListMap[index]['userID'][0];
    }
  }

  int findUser(int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    _userListMap.add(snapshot.data?.docs[index].data() as Map<String, dynamic>);
    if (_userListMap[index]['userID'][0] == id) {
      return 1;
    } else {
      return 0;
    }
  }

  Widget _messageTile(int index, ReceiverData receiverData) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseServices().getLastMessage(
            receiverId: receiverData.brandId!, senderId: senderId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            MessageData messageData = MessageData.fromJson(
                snapshot.data?.docs[0].data() as Map<String, dynamic>);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30), // Image radius
                      child: (receiverData.brandProfilePic != null)
                          ? Image.network(receiverData.brandProfilePic!,
                              fit: BoxFit.cover)
                          : const Icon(
                              Icons.account_circle_sharp,
                              color: Colors.grey,
                              size: 60,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverData.brandName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      (messageData.isMedia)
                          ? Row(
                              children: [
                                Icon(
                                  Icons.attachment,
                                  size: 14,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  messageData.mediaType,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            )
                          : Text(
                              messageData.message,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    Utilities().dateTimeConvertor(
                        date: messageData.sentAt!, onlyTime: true),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 10),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}
