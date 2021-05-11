import 'dart:async';
import 'dart:math';

import 'package:flutter_twitter_example/model/tweet.dart';

abstract class TweetRepository{
  factory TweetRepository()=>_FakeTweetRepository();

  const TweetRepository._();

  FutureOr<List<Tweet>> fetchMore(int pageNumber);
}

class _FakeTweetRepository extends TweetRepository{
  const _FakeTweetRepository(): super._();

  @override
  FutureOr<List<Tweet>> fetchMore(int pageNumber) {
    Random random = Random();
    if(pageNumber==1)
      return [
        for(int i=0; i<10;i++)
          Tweet({
            'writer_pic':'https://picsum.photos/id/$i/200/300',
            'writer_name':[
              'Henry Khang', 'Earleen Osei', 'Sanford Reinoso', 'Sandy Engleman', 'Janine Veal', 'Jerold Frisina', 'Eden Clink', 'Nora Resendes', 'Margit Bocanegra', 'Taunya Ballinger'
            ][i%10],
            'writer_id':[
              'henrykhang', 'earleenosei', 'sanfordreinoso', 'sandyengleman', 'janineveal', 'jeroldfrisina', 'edenclink', 'noraresendes', 'margitbocanegra', 'taunyaballinger'
            ][i%10],
            'tweet_message':'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
            'tweet_date':'${i+1} days ago',
            'tweet_video':random.nextBool()?'https://picsum.photos/id/${50+i}/200/300':null,
            'view_count':random.nextInt(50),
            'comment_count':random.nextInt(50),
            'retweet_count':random.nextInt(50),
            'like_count':random.nextInt(50),
          }),
      ];
    return [];
  }
}
