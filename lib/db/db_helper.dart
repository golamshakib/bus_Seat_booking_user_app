
import 'package:cloud_firestore/cloud_firestore.dart';


class DbHelper {
  DbHelper._();
  static final _db = FirebaseFirestore.instance;
  static const String _collectionBus = 'Buses';
  static const String _collectionRoute = 'Routes';
  static const String _collectionSchedule = 'Schedules';



  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBuses(){
    return _db.collection(_collectionBus).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRoutes(){
    return _db.collection(_collectionRoute).snapshots();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSchedulesByStartAndEndLocation(String start, String end){
   return _db.collection(_collectionSchedule)
       .where('route.startLocation', isEqualTo: start)
        .where('route.endLocation', isEqualTo: end)
       .snapshots();
  }

}
