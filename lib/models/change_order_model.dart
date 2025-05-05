class ChangeOrderModel
{
  late bool status;
  late String message;

  ChangeOrderModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}