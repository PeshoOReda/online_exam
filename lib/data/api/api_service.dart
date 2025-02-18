import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

      Uri url = Uri.parse(ApiConstant.baseUrl + ApiEndPoint.registerApi);
      var registerRequest = RegisterRequest(
          username: userName,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phoneNumber);
      var requestBody = jsonEncode(registerRequest.toJson());

      var response = await http.post(
        url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      try {
        var responseData = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = RegisterResponseDataModel.fromJson(responseData);
          return Right(registerResponse);
        } else {
          return Left(ServerError(
              errorMessage: responseData['message'] ?? 'Server Error: ${response.statusCode}'));
        }
      } catch (e) {
        return Left(ServerError(errorMessage: 'Invalid JSON response: $e'));
      }
    } on SocketException {
      return Left(NetworkError(errorMessage: 'No Internet Connection'));
    } on TimeoutException {
      return Left(ServerError(errorMessage: 'Request timed out'));
    } catch (e) {
      return Left(ServerError(errorMessage: 'Unexpected Error: $e'));
    }
  }
}
