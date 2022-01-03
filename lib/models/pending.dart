part of 'models.dart';


class Pending{
  final String pendingId;
  final String templateName;
  final String link;
  final String color;
  final String description;
  final String status;
  final String addBy;
  final String orderBy;


  const Pending(
      this.pendingId,
      this.templateName,
      this.link,
      this.color,
      this.description,
      this.status,
      this.addBy,
      this.orderBy
      );

  @override
  // TODO: implement props
  List<Object> get props => [
    pendingId,
    templateName,
    link,
    color,
    description,
    status,
    addBy,
    orderBy,
  ];
}