import 'package:flutter/material.dart';
import '../../domain/use_cases/contact_usecase.dart';
import '../../models/contact.dart';
import '../../presentations/configs/constants.dart';

class ContactViewModel extends ChangeNotifier {
  final ContactUseCase contactUseCase;
  ContactViewModel(this.contactUseCase);

  String _name = '';
  String _job = '';
  String _email = '';
  String _message = '';

  String? nameError;
  String? jobError;
  String? emailError;
  String? messageError;

  bool isSending = false;

  // Getters
  String? get name => _name;
  String? get job => _job;
  String? get email => _email;
  String? get message => _message;

  // Setters
  set name(String? value) {
    _name = value ?? '';
    validateField('name');
  }

  set job(String? value) {
    _job = value ?? '';
    validateField('job');
  }

  set email(String? value) {
    _email = value ?? '';
    validateField('email');
  }

  set message(String? value) {
    _message = value ?? '';
    validateField('message');
  }

  void validateField(String field) {
    switch (field) {
      case 'name':
        nameError = (_name.isEmpty) ? "Name is required" : null;
        break;
      case 'job':
        jobError = (_job.isEmpty) ? "Job type is required" : null;
        break;
      case 'email':
        emailError = (_email.isEmpty || !emailRegex.hasMatch(_email))
            ? "Valid email is required"
            : null;
        break;
    }
    notifyListeners();
  }

  void validate() {
    validateField('name');
    validateField('job');
    validateField('email');
    validateField('message');
  }

  bool get isFormValid =>
      nameError == null &&
      jobError == null &&
      emailError == null &&
      _name.isNotEmpty &&
      _job.isNotEmpty &&
      _email.isNotEmpty;

  void _setIsSending(bool value) {
    isSending = value;
    notifyListeners();
  }

  Future<bool> sendMessage() async {
    validate();

    if (!isFormValid) return false;

    try {
      _setIsSending(true);
      await contactUseCase.sendMessage(
        Contact(name: _name, email: _email, job: _job, message: _message),
      );

      _setIsSending(false);
      _clearData();

      return true; // success
    } catch (e, stackTrace) {
      _setIsSending(false);
      debugPrint('Send message error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false; // failure
    }
  }

  void _clearData() {
    _name = '';
    _email = '';
    _job = '';
    _message = '';
    notifyListeners();
  }
}
