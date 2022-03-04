import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
part 'checkout_reponse.g.dart';
@JsonSerializable()
class CheckoutResponse{

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  CheckoutVO? data;


  CheckoutResponse(this.code, this.message, this.data);


  @override
  String toString() {
    return 'CheckoutResponse{code: $code, message: $message, data: $data}';
  }

  factory  CheckoutResponse.fromJson(Map<String,dynamic>json) => _$CheckoutResponseFromJson(json);
  Map<String,dynamic> toJson() => _$CheckoutResponseToJson(this);
}