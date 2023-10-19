import 'package:hello_mdfk/qpp_sample/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_api.g.dart';

@RestApi(baseUrl: gcp)
abstract class ItemApi {
  factory ItemApi(Dio dio, {String baseUrl}) = _ItemApi;

  /// 商品列表資訊_查詢
  @POST("ItemSelect")
  Future<ItemSelectResponse> postItemSelect(@Body() itemIds);
  // options: Options(responseType: ResponseType.json));
}

@JsonSerializable()
class ItemSelectResponse {
  const ItemSelectResponse({required this.errorCode, required this.itemList});

  final String errorCode;
  final List<dynamic> itemList;

  factory ItemSelectResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemSelectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSelectResponseToJson(this);

  // Map<String, dynamic> getData() {
  //   return itemList[0];
  // }
}
