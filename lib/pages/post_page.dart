import 'package:flutter/material.dart';
import 'package:prism/components/my_comment_tile.dart';
import 'package:prism/components/my_post_tile.dart';
import 'package:prism/helper/naviagte_pages.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../services/database/database_provider.dart';

/*

POST PAGE

This page displays:

- individual post
- comments on this post

*/

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({
    super.key,
    required this.post,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //providers
  late final listeningProvider =
      Provider.of<DatabaseProvider>(context, listen: true);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //lkisten to all of the comments
    final allComments = listeningProvider.getComments(widget.post.id);

    //SCAFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      //Body
      body: ListView(
        children: [
          //post
          MyPostTile(
            post: widget.post,
            onUserTap: () => goUserPage(context, widget.post.uid),
            onPostTap: () {},
          ),

          const SizedBox(height: 25),

          //comments on this post
          allComments.isEmpty
              ? Center(
                  child: Text("No comments yet..."),
                )
              : ListView.builder(
                  itemCount: allComments.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //get each comment
                    final comment = allComments[index];
                    //return comment
                    return MyCommentTile(
                      comment: comment,
                      onUserTap: () => goUserPage(context, comment.uid),
                    );
                  },
                )
        ],
      ),
    );
  }
}
