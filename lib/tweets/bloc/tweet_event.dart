part of 'tweet_bloc.dart';

abstract class TweetEvent extends Equatable {
  const TweetEvent();
}

class FetchMoreEvent extends TweetEvent{
  const FetchMoreEvent();

  @override
  List<Object> get props => [];
}
