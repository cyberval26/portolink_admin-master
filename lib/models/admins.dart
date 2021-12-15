part of 'models.dart';

class Admins {
  final String uid;
  final String name;
  final String email;
  final String pass;
  final String createdAt;
  final String updatedAt;

  const Admins(
    this.uid,
    this.name,
    this.email,
    this.pass,
    this.createdAt,
    this.updatedAt,
  );
  List<Object> get props => [
    uid,
    name,
    email,
    pass,
    createdAt,
    updatedAt,
  ];
}