import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest {
  static final FirebaseTest _instance = FirebaseTest._internal();
  factory FirebaseTest() => _instance;

  FirebaseTest._internal();

  final db = FirebaseFirestore.instance;

  Future<void> addTest() async {
    try {
      await db.collection('test').add({
        'message': 'This is Test',
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Test data added successfully');
    } catch (e) {
      print('Error adding test data: $e');
    }
  }
}
