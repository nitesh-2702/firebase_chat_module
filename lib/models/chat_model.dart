
class MessageData {
  String senderId;
  String senderName;
  String senderAvatar;
  String message;
  DateTime? sentAt;
  bool isMedia;
  String mediaUrl;
  String mediaName;
  String mediaType;

  MessageData({
    this.senderName = '',
    this.senderId = '',
    this.sentAt,
    this.senderAvatar = '',
    this.message = '',
    this.isMedia = false,
    this.mediaUrl = '',
    this.mediaType = '',
    this.mediaName = '',
  });

  static MessageData fromJson(Map<String, dynamic> json) => MessageData(
        message: json['message'],
        sentAt: json['sentAt'].toDate(),
        senderName: json['senderName'],
        senderId: json['senderId'],
        senderAvatar: json['senderAvatar'],
        isMedia: json['isMedia'],
        mediaUrl: json['mediaUrl'],
        mediaType: json['mediaType'],
        mediaName: json['mediaName'],
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'senderName': senderName,
        'sentAt': sentAt,
        'message': message,
        'senderAvatar': senderAvatar,
        'isMedia': isMedia,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'mediaName': mediaName
      };
}
