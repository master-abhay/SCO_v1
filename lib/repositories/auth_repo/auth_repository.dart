import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/NetworkApiServices.dart';
import 'package:sco_v1/models/authentication/get_security_questions_model.dart';
import 'package:sco_v1/models/authentication/update_security_question_model.dart';
import 'package:sco_v1/resources/app_urls.dart';

import '../../models/authentication/signup_model.dart';

class AuthenticationRepository {
  //*-----Object of Api Services-----*
  final BaseApiServices _apiServices = NetworkApiServices();

  //*-----Signup Method-----*
  Future<SignupModel> signup(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _apiServices.getPostApiServices(
        url: AppUrls.signup, headers: headers, body: body);
    return SignupModel.fromJson(response);
  }

  //*-----Security Question Setup Start-----*

  //*------Get Security Question-------*
  Future<GetSecurityQuestionsModel> getSecurityQuestions(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
      url: '${AppUrls.baseUrl}users/$userId/security-questions',
      headers: headers,
    );
    return GetSecurityQuestionsModel.fromJson(response);
  }

  //*------Update Security Question-------*
  Future<UpdateSecurityQuestionModel> updateSecurityQuestion(
      {required String userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _apiServices.getPutApiServices(
      url: '${AppUrls.baseUrl}e-services/$userId/update-security-question',
      headers: headers,
      body: body
    );
    return UpdateSecurityQuestionModel.fromJson(response);
  }
//*-----Security Question Setup End-----*

//*-----Login Method-----*
}
