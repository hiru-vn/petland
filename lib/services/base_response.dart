
class BaseResponse {
  bool isSuccess;
  String errMessage;
  String message;
  dynamic data;

  BaseResponse(
      {this.errMessage, this.message, this.data, this.isSuccess = false});

  factory BaseResponse.success(dynamic data) {
    return BaseResponse(message: 'Thành công', data: data, isSuccess: true);
  }

  factory BaseResponse.fail(String err) {
    return BaseResponse(errMessage: err, isSuccess: false);
  }
}