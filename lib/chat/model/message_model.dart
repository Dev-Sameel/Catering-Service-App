class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createDon;

  MessageModel({this.messageId,this.sender, this.text, this.seen, this.createDon});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['messageId'];
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createDon = map['createDon'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId' : messageId,
      'sender': sender,
      'text' : text,
      'seen' : seen,
      'createDon' : createDon,
    };
  }
}
