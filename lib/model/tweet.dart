import 'package:equatable/equatable.dart';

class Tweet extends Equatable{
  final Map _map;

  Tweet(this._map);

  @override
  List<Object> get props => [_map];

  String get writerPic=>_map['writer_pic'];
  String get writerName=>_map['writer_name'];
  String get writerId=>_map['writer_id'];
  String get tweetMessage=>_map['tweet_message'];
  String get tweetDate=>_map['tweet_date'];
  String get tweetVideo=>_map['tweet_video'];
  String get viewCount=>tweetVideo==null?null:_map['view_count']?.toString();
  String get commentCount=>_map['comment_count']?.toString();
  String get retweetCount=>_map['retweet_count']?.toString();
  String get likeCount=>_map['like_count']?.toString();

}
