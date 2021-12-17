part of 'models.dart';

class Admins {
  final String aid;
  final String name;
  final String email;
  final String pass;
  final String createdAt;
  final String updatedAt;

  const Admins(
    this.aid,
    this.name,
    this.email,
    this.pass,
    this.createdAt,
    this.updatedAt,
  );
  List<Object> get props => [
    aid,
    name,
    email,
    pass,
    createdAt,
    updatedAt,
  ];
}