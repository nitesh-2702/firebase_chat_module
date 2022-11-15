import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_module/models/chat_model.dart';
import 'package:firebase_chat_module/utils/message_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  static final FirebaseServices firebaseServices = FirebaseServices._private();

  factory FirebaseServices() => firebaseServices;

  FirebaseServices._private();

  final firestoreDatabase = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final firebaseMessaging = FirebaseMessaging.instance;

  String getChatRoomId(String senderId, String receiverId) {
    if (!(senderId.compareTo(receiverId) <= 0)) {
      return "$receiverId\_$senderId";
    } else {
      return "$senderId\_$receiverId";
    }
  }

  Future<void> sendMessage({
    required BuildContext context,
    required String receiverId,
    required String receiverUserName,
    required MessageData messageData,
    required String senderId,
    required String senderUserName,
    required String senderProfilePic,
    required String receiverProfilePic,
  }) async {
    try {
      await firestoreDatabase
          .collection('chats')
          .doc(getChatRoomId(receiverId, senderId))
          .collection('messages')
          .add(messageData.toJson())
          .then((value) {
        firestoreDatabase
            .collection('chats')
            .doc(getChatRoomId(receiverId, senderId))
            .set({
          "userID": [senderId, receiverId],
          "userList": [
            {
              "id": senderId,
              "name": senderUserName,
              "profilePic": senderProfilePic
            },
            {
              "id": receiverId,
              "name": receiverUserName,
              "profilePic": receiverProfilePic
            }
          ]
        });
        MessageService.sendMessageNotification(
            receiverId: receiverId,
            senderId: senderId,
            message: messageData.message);
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (e.message.toString()),
          ),
        ),
      );
    }
  }

  Stream<QuerySnapshot> getLastMessage({
    required String receiverId,
    required String senderId,
  }) {
    return firestoreDatabase
        .collection('chats')
        .doc(getChatRoomId(senderId, receiverId))
        .collection('messages')
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessageStream({
    required String chatId,
  }) {
    return firestoreDatabase
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sentAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessageList(String senderId) {
    return firestoreDatabase
        .collection('chats')
        .where('userID', arrayContains: senderId)
        .snapshots();
  }

  Future<String> uploadFile(File file, String fileName, String senderId) async {
    var reference = firebaseStorage.ref().child(
        '$senderId/${DateTime.now().millisecondsSinceEpoch}_$fileName'); // get a reference to the path of the image directory
    var uploadTask = await reference.putFile(file);
    var data = await uploadTask.ref.getDownloadURL();
    return data;
  }
}
