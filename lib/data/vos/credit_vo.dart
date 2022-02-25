import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
part 'credit_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_CREDIT_ID,adapterName: "CreditVOAdapter")
class CreditVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(2)
  String? profilePath;

  @JsonKey(name: "credit_id")
  @HiveField(3)
  String? creditId;


  CreditVO(this.id, this.name, this.profilePath, this.creditId);




  factory CreditVO.fromJson(Map<String,dynamic>json) => _$CreditVOFromJson(json);
  Map<String,dynamic> toJson() => _$CreditVOToJson(this);
}