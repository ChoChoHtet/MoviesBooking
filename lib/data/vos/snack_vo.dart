import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_SNACK_LIST, adapterName: "SnackVOAdapter")
class SnackVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  @JsonKey(name: "price")
  @HiveField(3)
  int? price;

  @JsonKey(name: "image")
  @HiveField(4)
  String? image;

  @HiveField(5)
  int? quantity;

  SnackVO({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          image == other.image &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      image.hashCode ^
      quantity.hashCode;

  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackVOToJson(this);
}
