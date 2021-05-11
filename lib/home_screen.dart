import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_example/model/tweet.dart';
import 'package:flutter_twitter_example/tweets/bloc/tweet_bloc.dart';
import 'package:flutter_twitter_example/utils.dart';
import 'package:flutter_twitter_example/widgets/lazy_scroll.dart';

const _imageHalfSize = 25.0;
//TODO style and change margins/colors

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TweetBloc>(
      create: (context) => TweetBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showSnackBar(context, 'Compose a tweet.'),
          tooltip: 'Compose',
          child: Icon(Icons.create),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LazyScroll(
      builder: (context, controller) => BlocBuilder<TweetBloc, TweetState>(
        buildWhen: (previous, current) => current is FetchedState /*|| ...*/,
        builder: (context, state) => ListView.builder(
          itemBuilder: (context, index) =>
              _TweetItem(tweet: (state as FetchedState).tweets[index]),
          itemCount: state is FetchedState ? state.tweets.length : 0,
        ),
      ),
      loadMore: () {
        TweetBloc tweetBloc = BlocProvider.of<TweetBloc>(context);
        tweetBloc.add(FetchMoreEvent());
      },
    );
  }
}

class _TweetItem extends StatelessWidget {
  final Tweet tweet;

  const _TweetItem({this.tweet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WriterImage(tweet.writerPic),
            const SizedBox(width: 8.0),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(tweet.writerName),
                    const SizedBox(width: 8.0),
                    Text('@${tweet.writerId}'),
                  ],
                ),
                const SizedBox(height: 8.0),
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(tweet.tweetMessage)),
                const SizedBox(height: 8.0),
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(tweet.tweetDate)),
                const SizedBox(height: 8.0),
                if (tweet.tweetVideo != null) ...[
                  _TweetVideo(tweet.tweetVideo),
                  const SizedBox(height: 8.0),
                ],
                if (tweet.viewCount != null) ...[
                  Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('${tweet.viewCount} views')),
                  const SizedBox(height: 8.0),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: () =>
                                showSnackBar(context, 'Show comments')),
                        Text(tweet.commentCount),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.repeat),
                            onPressed: () =>
                                showSnackBar(context, 'Retweets!')),
                        Text(tweet.retweetCount),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () => showSnackBar(context, 'Like!')),
                        Text(tweet.likeCount),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () => showSnackBar(context, 'Share!')),
                  ],
                ),
              ],
            )),
            const SizedBox(width: 8.0),
            PopupMenuButton<int>(
              onSelected: (value) => showSnackBar(context, 'Action $value!'),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WriterImage extends StatelessWidget {
  final String image;
  const _WriterImage(
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_imageHalfSize),
      child: Image.network(
        image,
        width: _imageHalfSize * 2,
        height: _imageHalfSize * 2,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _TweetVideo extends StatelessWidget {
  final String tweetVideo;
  const _TweetVideo(
      this.tweetVideo
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.network(tweetVideo,
                  fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
              child: Center(
                  child: IconButton(
                    icon: Icon(Icons.play_arrow,
                        size: 60.0, color: Colors.white),
                    onPressed: () =>
                        showSnackBar(context, 'Play the video!'),
                    padding: EdgeInsets.zero,
                  ))),
        ],
      ),
    );
  }
}
