class ChatBubbleModel{

bool? isMe;
String? text;
String? dateTime;
String? image;

ChatBubbleModel({
  this.isMe,this.text,this.dateTime,this.image
});

factory ChatBubbleModel.fromJson(Map<String, dynamic> json) => ChatBubbleModel(
  isMe: json["isMe"] ?? false,
  text: json["text"] ?? null,
  dateTime: json["dateTime"] ?? null,
  image: json["image"] ?? null,
);

Map<String, dynamic> toJson() => {
  "isMe": isMe,
  "text": text ,
  "dateTime": dateTime,
  "image": image ,
};

}