import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/card_vo.dart';

part 'get_card_response.g.dart';
@JsonSerializable()
class GetCardResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CardVO>? data;

  GetCardResponse(this.code, this.message, this.data);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCardResponse &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;

  factory GetCardResponse.fromJson(Map<String,dynamic>json) => _$GetCardResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCardResponseToJson(this);


}