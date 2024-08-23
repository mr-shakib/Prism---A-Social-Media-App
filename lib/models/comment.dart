/*

COMMENT MODEL

This model will be used to store comments.

*/

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId;
  final String? parentCommentId; // Add this field
  final String uid;
  final String name;
  final String username;
  final String message;
  final Timestamp timestamp;
  final List<String> replyIds; // Add this field

  Comment({
    required this.id,
    required this.postId,
    this.parentCommentId,
    required this.uid,
    required this.name,
    required this.username,
    required this.message,
    required this.timestamp,
    this.replyIds = const [],
  });

  // Update fromDocument and toMap methods
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      id: doc.id,
      postId: doc['postId'],
      parentCommentId: doc['parentCommentId'],
      uid: doc['uid'],
      name: doc['name'],
      username: doc['username'],
      message: doc['message'],
      timestamp: doc['timestamp'],
      replyIds: List<String>.from(doc['replyIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'parentCommentId': parentCommentId,
      'uid': uid,
      'name': name,
      'username': username,
      'message': message,
      'timestamp': timestamp,
      'replyIds': replyIds,
    };
  }
}
