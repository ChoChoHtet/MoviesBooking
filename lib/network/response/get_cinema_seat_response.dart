import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';

part 'get_cinema_seat_response.g.dart';
@JsonSerializable()
class GetCinemaSeatResponse{
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
 List< List<CinemaSeatVO>>? data;


  GetCinemaSeatResponse(this.code, this.message, this.data);

  factory GetCinemaSeatResponse.fromJson(Map<String,dynamic>json) => _$GetCinemaSeatResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetCinemaSeatResponseToJson(this);
}