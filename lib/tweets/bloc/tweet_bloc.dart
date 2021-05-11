import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_example/model/tweet.dart';
import 'package:flutter_twitter_example/tweets/tweet_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'tweet_event.dart';

part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final TweetRepository repository = TweetRepository();

  final BehaviorSubject<int> _pageNumSubject = BehaviorSubject();
  final BehaviorSubject<List<Tweet>> _tweetsSubject = BehaviorSubject();

  TweetBloc() : super(InitialState());

  @override
  Stream<TweetState> mapEventToState(TweetEvent event) async* {
    if(event is FetchMoreEvent){
      int newPageNumber = (_pageNumSubject.value??0) + 1;
      List<Tweet> newTweets = repository.fetchMore(newPageNumber);
      if(newTweets.isNotEmpty){
        _pageNumSubject.add(newPageNumber);
        _tweetsSubject.add((_tweetsSubject.value??[]) + newTweets);
        yield FetchedState(_tweetsSubject.value);
      }
    }
  }

  @override
  Future<void> close() async{
    await _pageNumSubject.close();
    await _tweetsSubject.close();
    return super.close();
  }
}
