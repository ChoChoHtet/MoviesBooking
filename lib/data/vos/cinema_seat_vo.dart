import 'package:json_annotation/json_annotation.dart';

part 'cinema_seat_vo.g.dart';

@JsonSerializable()
class CinemaSeatVO {
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

  bool? isSelected = false;

  CinemaSeatVO({
    this.id,
    this.type,
    this.seatName,
    this.symbol,
    this.price,
    this.isSelected,
  });

  bool isSeatTypeAvailable() => this.type == "available";

  bool isSeatTypeText() => this.type == "text";

  bool isSeatTypeSpace() => this.type == "space";

  bool isSeatTypeTaken() => this.type == "taken";

  @override
  String toString() {
    return 'CinemaSeatVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaSeatVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          seatName == other.seatName &&
          symbol == other.symbol &&
          price == other.price &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      seatName.hashCode ^
      symbol.hashCode ^
      price.hashCode ^
      isSelected.hashCode;

  factory CinemaSeatVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaSeatVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaSeatVOToJson(this);
}
