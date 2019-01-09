
class Model {
  String title, user, timeAgo, type, urls, domain ;
  int id ,points , time, commentsCount;

  Model(
      {this.id,
        this.title,
        this.points,
        this.user,
        this.time,
        this.timeAgo,
        this.commentsCount,
        this.type,
        this.urls,
        this.domain});

  factory Model.fromJson(Map<String,dynamic> parsedJson) {
    print(parsedJson['title']);
    return Model(
        title: parsedJson['title'],
        id: parsedJson['id'],
        points: parsedJson['points'],
        user: parsedJson['user'],
        time: parsedJson['time'],
        timeAgo: parsedJson['time_ago'],
        commentsCount: parsedJson['comments_count'],
        type: parsedJson['type'],
        urls: parsedJson['url'],
        domain: parsedJson['domain']);
  }
}