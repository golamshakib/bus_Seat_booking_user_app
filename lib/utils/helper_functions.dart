
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getFormatedDateTime(DateTime dt, {String pattern = 'dd-MM-yyyy'}) {
   return DateFormat(pattern).format(dt);
}

String generateBookingId(String userName) =>
    '${userName.trim()}_${getFormatedDateTime(DateTime.now(), pattern: 'yyyyMMdd_hh:mm:ss')}';
