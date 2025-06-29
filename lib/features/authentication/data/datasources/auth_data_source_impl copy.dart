// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';

// import '../../../../core/config/environment_config.dart';
// import '../../domain/datasources/auth_data_source.dart';
// import '../models/google_sheet_response.dart';
// import '../models/user_model.dart';

// class AuthDataSourceImpl implements AuthDataSource {
//   final dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//     ),
//   );

//   final baseUrl = EnvironmentConfig().authBaseUrl;

//   @override
//   Future<UserModel> login({
//     required String email,
//     required String password,
//   }) async {
//     final response = await doPost({
//       "comando": "login",
//       "parametros": {"email": email, "password": password},
//     });

//     try {
//       if (response?.data == null) {
//         throw Exception('No se pudo obtener la respuesta');
//       }
//       final dataResponse = response!.data;
//       final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
//       if (googleSheetResponse.hasError) {
//         throw Exception(googleSheetResponse.msg);
//       }
//       return UserModel.fromJson(googleSheetResponse.data!);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<void> logout() async {}

//   @override
//   Future<void> changePassword({
//     required String newPassword,
//     required String token,
//   }) async {
//     final response = await doPost({
//       "comando": "change_password",
//       "parametros": {"token": token, "new_password": newPassword},
//     });

//     try {
//       if (response?.data == null) {
//         throw Exception('No se pudo obtener la respuesta');
//       }
//       final dataResponse = response!.data;
//       final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
//       if (googleSheetResponse.hasError) {
//         throw Exception(googleSheetResponse.msg);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<void> recoveryPassword({required String email}) async {
//     final response = await doPost({
//       "comando": "recovery_password",
//       "parametros": {"email": email},
//     });

//     try {
//       if (response?.data == null) {
//         throw Exception('No se pudo obtener la respuesta');
//       }
//       final dataResponse = response!.data;
//       final googleSheetResponse = GoogleSheetResponse.fromJson(dataResponse);
//       if (googleSheetResponse.hasError) {
//         throw Exception(googleSheetResponse.msg);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response<dynamic>?> doPost(Map<String, dynamic> body) async {
//     final bodyJson = jsonEncode(body);
//     Response<dynamic>? response;
//     try {
//       response = await dio.post(
//         baseUrl,
//         options: Options(
//           headers: {
//             HttpHeaders.contentTypeHeader: "application/json"
//             },
//         ),
//         data: bodyJson,
//       );
//     } on DioException catch (e) {
//       /// Handle redirect with code 302
//       if (e.response?.statusCode == 302) {
//         final url = e.response?.headers['location']!.first;
//         response = await dio.get(url!);
//       } else {
//         rethrow;
//       }
//     }
//     return response;
//   }
// }
