import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomModel{
  String? chatRoomId;
  Map<String,dynamic>? participants;
  String? lastMessage;
  List<dynamic>? users;
  DateTime? createDon;

  ChatRoomModel({this.chatRoomId,this.participants,this.lastMessage,this.users,this.createDon});

  ChatRoomModel.fromMap(Map<String,dynamic> map)
  {
    chatRoomId = map['chatRoomId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
    users=map['users'];
    createDon=map['createDon'].toDate();
  }

  Map<String,dynamic> toMap()
  {
    return {
      'chatRoomId' :chatRoomId,
      'participants' : participants,
      'lastMessage' : lastMessage,
      'users':users,
      'createDon':createDon,
    };
  }
}