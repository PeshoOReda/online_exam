import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/data/models/response/Register_response_data_model.dart';
import '../../domain/entity/failures.dart';
import '../models/request/Register_request.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

@singleton
class ApiService {
  static ApiService? _instance;

  static ApiService getInstance() {
    _instance ??= ApiService();
    return _instance!;
  }

  Future<Either<Failures, RegisterResponseDataModel>> register(
      String email,
      String password,
      String userName,
      String firstName,
      String lastName,
      String phoneNumber,
      String rePassword) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Left(NetworkError(errorMessage: 'No Internet Connection'));
      }

      Uri url = Uri.parse(ApiConstant.baseUrl+ ApiEndPoint.registerApi);
      var registerRequest = RegisterRequest(
          username:userName,
          firstName:firstName,
          lastName:lastName,
          email:email,
          password:password,
          rePassword:rePassword,
          phone:phoneNumber
      );

      var requestBody = jsonEncode(registerRequest.toJson());
      print('Request body: $requestBody');

      var response = await http.post(
        url,
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var registerResponse = RegisterResponseDataModel.fromJson(jsonDecode(response.body));
        return Right(registerResponse);
      } else {
        return Left(ServerError(errorMessage: 'Server Error: ${response.statusCode}'));
      }
    } catch (e) {
      print('Unexpected Error: $e');
      return Left(ServerError(errorMessage: 'Unexpected Error: $e'));
    }
  }
}

