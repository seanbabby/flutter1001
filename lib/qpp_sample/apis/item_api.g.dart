// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSelectResponse _$ItemSelectResponseFromJson(Map<String, dynamic> json) =>
    ItemSelectResponse(
      errorCode: json['errorCode'] as String,
      itemList: json['itemList'] as List<dynamic>,
    );

Map<String, dynamic> _$ItemSelectResponseToJson(ItemSelectResponse instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'itemList': instance.itemList,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ItemApi implements ItemApi {
  _ItemApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev2-api.qpptec.com/client/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ItemSelectResponse> postItemSelect(dynamic itemIds) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = itemIds;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ItemSelectResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'ItemSelect',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ItemSelectResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
