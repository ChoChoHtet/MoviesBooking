import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';

part 'get_credit_response.g.dart';
@JsonSerializable()
class GetCreditResponse{
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "cast")
  List<CreditVO>? cast;

  GetCreditResponse(this.id, this.cast);

  factory GetCreditResponse.fromJson(Map<String,dynamic>json) => _$GetCreditResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCreditResponseToJson(this);
}