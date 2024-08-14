import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:prism/components/my_input_alert_box.dart';
import 'package:prism/components/my_post_tile.dart';
import 'package:prism/helper/naviagte_pages.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/post.dart';
import '../services/database/database_provider.dart';

/*

HOME PAGE

This is the home page of the app. It displays list of all the posts

*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  //provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);

  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  //text controller
  final _messageController = TextEditingController();

  //on startup
  @override
  void initState() {
    super.initState();

    //get posts
    loadAllPosts();
  }

  //load all posts
  Future<void> loadAllPosts() async {
    await databaseProvider.loadAllPosts();
  }

  //handle refresh
  Future<void> _handleRefresh() async {
    await loadAllPosts();
    return await Future.delayed(Duration(seconds: 1));
  }

  //show post message box
  void _openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
        textController: _messageController,
        hintText: "What's on your mind?",
        onPressed: () async {
          //post in db
          await postMessage(_messageController.text);
        },
        onPressedText: "Post",
      ),
    );
  }

  //user wants to post a message
  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    // TAB CONTROLLER
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        // Body
        body: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: Colors.deepPurple,
          height: 300,
          backgroundColor: Colors.deepPurple[200],
          animSpeedFactor: 2,
          child: Column(
            children: [
              // TabBar
              PreferredSize(
                preferredSize:
                    Size.fromHeight(50.0), // Adjust the height as needed
                child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: Theme.of(context).colorScheme.inversePrimary,
                  unselectedLabelColor: Theme.of(context).colorScheme.primary,
                  indicatorColor: Colors.deepPurple,
                  tabs: const [
                    Tab(text: "For You"),
                    Tab(text: "Following"),
                  ],
                ),
              ),

              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    _buildPostList(
                      listeningProvider.allPosts, // For "For You" tab
                    ),
                    _buildPostList(
                      listeningProvider.followingPosts, // For "Following" tab
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //build list UI give a list of posts

// Your build post list function
  Widget _buildPostList(List<Post> posts) {
    return posts.isEmpty
        ? ListView.builder(
            itemCount: 15, // Number of shimmer placeholders
            itemBuilder: (context, index) => _buildShimmerPlaceholder(),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return MyPostTile(
                post: post,
                onUserTap: () => goUserPage(context, post.uid),
                onPostTap: () => goPostPage(context, post),
              );
            },
          );
  }

// Shimmer placeholder
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primary,
      highlightColor: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular avatar
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10.0),
                // Name and time placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Post content placeholder
            Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
            ),
            const SizedBox(height: 10.0),
            // Like, comment, share placeholders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50.0,
                  height: 10.0,
                  color: Colors.white,
                ),
                Container(
                  width: 50.0,
                  height: 10.0,
                  color: Colors.white,
                ),
                Container(
                  width: 50.0,
                  height: 10.0,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
