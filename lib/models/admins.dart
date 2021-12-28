part of 'models.dart';

class Admins {
  final String aid;
  final String email;
  final String pass;
  final String createdAt;
  final String updatedAt;
  const Admins(
    this.aid,
    this.email,
    this.pass,
    this.createdAt,
    this.updatedAt
  );
  List<Object> get props => [
    aid,
    email,
    pass,
    createdAt,
    updatedAt
  ];
}