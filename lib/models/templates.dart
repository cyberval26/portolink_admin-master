part of 'models.dart';

class Templates extends Equatable {
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
  @override
  List<Object> get props => [
        tId,
        tName,
        tDesc,
        tPrice,
        tPhoto,
      ];
}