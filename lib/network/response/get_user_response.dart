
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/user_vo.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class GetUserResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name: "data")
  UserVO? data;

  @JsonKey(name: "token")
  String? token;


  GetUserResponse(this.code, this.message, this.data, this.token);


  @override
  String toString() {
    return 'GetUserResponse{code: $code, message: $message, data: $data, token: $token}';
  }

  factory GetUserResponse.fromJson(Map<String,dynamic>json) => _$GetUserResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetUserResponseToJson(this);

}