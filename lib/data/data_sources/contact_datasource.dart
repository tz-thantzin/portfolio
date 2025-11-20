import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart' show Logger;
import '../../models/contact.dart';

class ContactDatasource {
  final FirebaseFirestore _firestore;

  ContactDatasource({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> sendMessage(Contact contact) async {
    try {
      await _firestore
          .collection("message")
          .doc(contact.email)
          .collection("user_messages")
          .add({
            ...contact.toJson(),
            'createdAt': FieldValue.serverTimestamp(),
          });
    } catch (ex) {
      Logger().e(ex);
      throw Exception(ex.toString());
    }
  }
}
