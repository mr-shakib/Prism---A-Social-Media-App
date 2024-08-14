/*

TIMESTAMP

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return timeago.format(dateTime);
}
