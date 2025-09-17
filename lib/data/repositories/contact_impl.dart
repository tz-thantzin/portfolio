import 'package:cloud_firestore/cloud_firestore.dart' as firebase_core;
import 'package:logger/logger.dart';
import 'package:portfolio/data/data_sources/contact_datasource.dart';
import 'package:portfolio/domain/repositories/contact_repository.dart';
import 'package:portfolio/models/contact.dart';

class ContactImpl extends ContactRepository {
  final ContactDatasource _datasource;

  ContactImpl(this._datasource);

  @override
  Future<void> sendMessage(Contact contact) async {
    try {
      await _datasource.sendMessage(contact);
    } on firebase_core.FirebaseException catch (e) {
      Logger().e(e);
      throw Exception(e.toString());
    } catch (e) {
      Logger().e(e);
      throw Exception(e.toString());
    }
  }
}
