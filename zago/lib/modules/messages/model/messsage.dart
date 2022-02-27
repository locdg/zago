class Message {
  int id;
  String avatar;

  String nameContact;
  String lastMessage;
  int lastTimeMessage;
  bool isRead;

  Message(this.id, this.avatar, this.nameContact, this.lastMessage,
      this.lastTimeMessage, this.isRead);

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        avatar = json['avatar'] ?? "",
        nameContact = json['nameContact'] ?? "",
        lastMessage = json['lastMessage'] ?? "",
        lastTimeMessage = json['lastTimeMessage'] ?? 0,
        isRead = json['isRead'] ?? false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'avatar': avatar,
        'nameContact': nameContact,
        'lastMessage': lastMessage,
        'lastTimeMessage': lastTimeMessage,
        'isRead': isRead,
      };
}
