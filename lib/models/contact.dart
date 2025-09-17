import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String name;
  final String email;
  final String job;
  final String message;
  Contact({
    required this.name,
    required this.email,
    required this.job,
    this.message = '',
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json['name'],
    job: json['job'],
    email: json['email'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "email": email,
    "message": message,
  };

  @override
  List<Object?> get props => [name, job, email, message];
}
