import 'package:logger/logger.dart';
import 'package:portfolio/domain/repositories/contact_repository.dart';

import '../../models/contact.dart';

class ContactUseCase {
  final ContactRepository _repository;

  ContactUseCase(this._repository);

  Future<void> sendMessage(Contact contact) async {
    try {
      await _repository.sendMessage(contact);
    } catch (e) {
      Logger().e(e);
    }
  }
}
