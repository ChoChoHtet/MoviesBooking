import 'package:json_annotation/json_annotation.dart';

part 'cinema_seat_vo.g.dart';
@JsonSerializable()
class CinemaSeatVO{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;

  bool? isSelected;


  CinemaSeatVO(this.id, this.type, this.seatName, this.symbol, this.price,
      this.isSelected);


  @override
  String toString() {
    return 'CinemaSeatVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price, isSelected: $isSelected}';
  }

  factory CinemaSeatVO.fromJson(Map<String,dynamic>json) => _$CinemaSeatVOFromJson(json);
  Map<String,dynamic> toJson() => _$CinemaSeatVOToJson(this);

}