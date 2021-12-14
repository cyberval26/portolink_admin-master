part of 'models.dart';

class Admins {
  final String uid;
  final String aName;
  final String aEmail;
  final String aPass;
  final String createdAt;
  final String updateAt;

  const Admins(
    this.uid,
    this.aName,
    this.aEmail,
    this.aPass,
    this.createdAt,
    this.updateAt,
  );
  List<Object> get props => [
        uid,
        aName,
        aEmail,
        aPass,
        createdAt,
        updateAt,
  ];
}