// import 'dart:io';
// import 'package:golden_test/Core/urls.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
//
//
// Future signUp(
//     {required PlatformFile profileFile,
//       required File profileImage,
//       required String name,
//       required String email,
//       required String password,
//       required String city,
//       required String phone,
//       required String latitude,
//       required String longitude,
//       required String bankName,
//       required String iban,
//
//     }) async {
//   final uri = Uri.parse(kSignUpUrl);
//   var request =  http.MultipartRequest('POST', uri);
//   final profileHttpImage = http.MultipartFile.fromBytes('photo', profileFile.bytes!,
//       filename: profileImage.path.split("/").last);
//   final residencyHttpImage = http.MultipartFile.fromBytes('residency_photo', profileFile.bytes!,
//       filename: profileImage.path.split("/").last);
//   request.files.add(profileHttpImage);
//   request.files.add(residencyHttpImage);
//   request.fields['name'] = name;
//   request.fields['email'] = email;
//   request.fields['password'] = password;
//   request.fields['city'] = city;
//   request.fields['phone'] = phone;
//   request.fields['latitude'] = latitude;
//   request.fields['longitude'] = longitude;
//   request.fields['bank_name'] = bankName;
//   request.fields['iban'] = iban;
//   request.fields['longitude'] = longitude;
//
//   final response = await request.send();
//   final respStr = await response.stream.bytesToString();
//   print(respStr);
//   if(response.statusCode == 200){
//     return 'success';
//   }else{
//     return 'error';
//   }
// }