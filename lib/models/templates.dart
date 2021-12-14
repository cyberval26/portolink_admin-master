part of 'models.dart';

class Templates {
  final String tId;
  final String tName;
  final String tDesc;
  final String tPrice;
  final String tPhoto;

  const Templates(
    this.tId,
    this.tName,
    this.tDesc,
    this.tPrice,
    this.tPhoto,
  );
  List<Object> get props => [
        tId,
        tName,
        tDesc,
        tPrice,
        tPhoto,
      ];
}