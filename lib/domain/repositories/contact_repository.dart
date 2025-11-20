import '../../models/contact.dart';

abstract class ContactRepository {
  Future<void> sendMessage(Contact contact);
}
