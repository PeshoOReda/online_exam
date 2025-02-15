import 'package:dartz/dartz.dart';
import 'package:online_exam/domain/repository/repository_contract/auth_repository_contract.dart';

import '../entity/auth_result_entity.dart';
import '../entity/failures.dart';

class RegisterUseCase {
 AuthRepositoryContract authRepositoryContract;
 RegisterUseCase( {required this.authRepositoryContract});

 Future<Either<Failures, AuthResultEntity>> invoke(String userName, String firstName, String lastName, String email, String password, String rePassword, String phoneNumber)async{
   return await authRepositoryContract.register(email, password, userName, firstName, lastName, phoneNumber, rePassword);
 }
}
