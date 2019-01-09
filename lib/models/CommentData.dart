
 class CommentDataModel {

  String  user ,title , type , url ,timeAgo,content;
  int  id, time ,commentCount,level;
  List<CommentDataModel>comments;

  CommentDataModel({
   this.user , this.title,this.type,this.url,this.id,this.content,this.time ,this.commentCount,this.timeAgo,this.comments
 });

  factory CommentDataModel.fromMap(Map<String,dynamic> parsedValues){
    return CommentDataModel(
        title : parsedValues["title"],
        type : parsedValues["type"],
        url : parsedValues["url"],
        user : parsedValues["user"],
        content : parsedValues["content"],
        timeAgo : parsedValues["time_ago"],
        id : parsedValues["id"],
        comments: parsedValues["comments"],
        time : parsedValues["time"]);
  }


}
