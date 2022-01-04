part of 'models.dart';

class Requests {
  final String orderId;
  final String templateName;
  final String color;
  final String contact;
  final String requestDescription;
  final String photoReference;
  final String addBy;
  final String pendingBy;
  final String status;
  final String createdAt;
  const Requests(
    this.orderId,
    this.templateName,
    this.color,
    this.contact,
    this.requestDescription,
    this.photoReference,
    this.addBy,
    this.pendingBy,
    this.status,
    this.createdAt
  );
  List<Object> get props => [
    orderId,
    templateName,
    color,
    contact,
    requestDescription,
    photoReference,
    addBy,
    pendingBy,
    status,
    createdAt
  ];
}