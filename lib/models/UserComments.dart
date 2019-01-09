import 'package:hacker_news/models/CommentData.dart';

class UserComments {
  String user,title, timeAgo, type, content, url;
  int id, commentCount, level, time;

  List<UserComments> comments; //children

  UserComments(
      {this.user,
      this.timeAgo,
      this.type,
      this.content,
      this.comments,
      this.url,
        this.title,
      this.id,
      this.time,
      this.commentCount,
      this.level});

  factory UserComments.fromJson(Map<String, dynamic> parsedJson) {
    List commentsList = parsedJson["comments"] as List;
    List<UserComments> list = new List();
    if(commentsList.length != 0) {
       list.addAll((commentsList)
           .map((data) => UserComments.fromJson(data))
           .toList());
       //list.addAll(parsedJson["comments"] as Map);
    }
    return UserComments(
        id: parsedJson["id"],
        user: parsedJson["user"],
        timeAgo: parsedJson["time_ago"],
        time: parsedJson["time"],
        title: parsedJson["title"],
        type: parsedJson["type"],
        content: parsedJson["content"],
        commentCount: parsedJson["comment_count"],
        comments: list,
        url: parsedJson["url"],
        level: parsedJson["level"]);
  }
}
