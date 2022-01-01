part of 'models.dart';

class Requests {
  final String oid;
  final String name;
  final String color;
  final String contact;
  final String requestDescription;
  final String photoReference;
  final String createdAt;
  const Requests(
    this.oid,
    this.name,
    this.color,
    this.contact,
    this.requestDescription,
    this.photoReference,
    this.createdAt,
  );
  List<Object> get props => [
    oid,
    name,
    color,
    contact,
    requestDescription,
    photoReference,
    createdAt,
  ];
}