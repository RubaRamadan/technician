import 'package:dio/dio.dart';
import '../Core/urls.dart';
import 'dart:typed_data';

Future signUp(
    {required Uint8List residencyImageFile,
    required Uint8List profileImageFile,
    required String name,
    required String email,
    required String password,
    required String city,
    required String phone,
    required String latitude,
    required String longitude,
    required String bankName,
    required String iban,
    required List subCategoriesIds}) async {
  FormData formData = FormData.fromMap({
    "name": name,
    "email": email,
    "password": password,
    "city": city,
    "phone": phone,
    "latitude": latitude,
    "longitude": longitude,
    "bank_name": bankName,
    "iban": iban,
    "residency_photo":
        MultipartFile.fromBytes(residencyImageFile, filename: "image.jpg"),
    "photo": MultipartFile.fromBytes(profileImageFile, filename: "image.jpg")
  });
  for (int i = 0; i < subCategoriesIds.length; i++) {
    formData.fields
        .addAll([MapEntry("sub_categories[$i]", '${subCategoriesIds[i]}')]);
  }

  Response response = await Dio()
      .post(kSignUpUrl,
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Accept": "application/json",
          }))
      .catchError((err) {
    if (err is DioError) {
      print(err.response);
    }
  });
  if (response.statusCode == 200) {
    return 'success';
  } else {
    return 'error';
  }
}
