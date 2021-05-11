part of 'tweet_bloc.dart';

abstract class TweetState extends Equatable {
  const TweetState();
}

class InitialState extends TweetState {
  const InitialState();
  @override
  List<Object> get props => [];
}

class FetchedState extends TweetState{
  final List<Tweet> tweets;

  const FetchedState(this.tweets);

  @override
  List<Object> get props => [tweets];
}