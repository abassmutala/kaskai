class Chat {
  final String uid;
  final String sender;
  final String receiver;
  final String message;

  Chat(
      {required this.uid,
      required this.sender,
      required this.receiver,
      required this.message});

  factory Chat.senderJson(Map<String, dynamic> json) {
    return Chat(
      uid: json['uid'],
      sender: json['sender'],
      receiver: json['receiver'],
      message: json['message'],
    );
  }
}
