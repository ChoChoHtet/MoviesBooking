
import 'package:json_annotation/json_annotation.dart';
part 'common_response.g.dart';
@JsonSerializable()
class CommonResponse{
  @JsonKey(name: "code")
  int? code;


  @JsonKey(name: "message")
  String? message;

  CommonResponse(this.code, this.message);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonResponse &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message;

  @override
  int get hashCode => code.hashCode ^ message.hashCode;

  factory CommonResponse.fromJson(Map<String,dynamic>json) => _$CommonResponseFromJson(json);

  Map<String,dynamic> toJson() => _$CommonResponseToJson(this);
}