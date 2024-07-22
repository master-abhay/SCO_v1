import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sco_v1/models/authentication/resend_otp_model.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/authentication/otp_verification_model.dart';
import '../../repositories/auth_repo/auth_repository.dart';
import '../../utils/constants.dart';
import '../language_change_ViewModel.dart';
import '../services/alert_services.dart';

class OtpVerificationViewModel with ChangeNotifier {
  late AlertServices _alertServices;

  OtpVerificationViewModel() {
    final GetIt getIt = GetIt.instance;
    _alertServices = getIt.get<AlertServices>();
  }

//*----------Otp Verification Start--------*

  String? _userId;
  String? _otp;

  _setUserId(String? userId) async {
    _userId = userId;
    notifyListeners();
  }

  _setOtp(String? otp) async {
    _otp = otp;
    notifyListeners();
  }

  //*------Accessing Api Services------*
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ApiResponse<OtpVerificationModel> _otpVerificationResponse =
      ApiResponse.none();

  ApiResponse<OtpVerificationModel> get otpVerificationResponse =>
      _otpVerificationResponse;

  set _setVerificationResponse(ApiResponse<OtpVerificationModel> response) {
    _otpVerificationResponse = response;
    notifyListeners();
  }

  Future<bool> verifyOtp(
      {required BuildContext context,
      required LanguageChangeViewModel langProvider,
      String? userId,
      required String otp}) async {
    try {
      _setVerificationResponse = ApiResponse.loading();

      //*-----Setting Values Start------*
      await _setUserId(userId);
      await _setOtp(otp);

      debugPrint(_userId);
      debugPrint(_otp);
      //*-----Setting Values End------*

      //*-----Create Headers Start-----*
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'authorization': Constants.basicAuth
      };
      //*-----Create Headers End-----*

      if (_userId == null ||
          _otp == null ||
          _userId!.isEmpty ||
          _otp!.isEmpty) {
        _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.error_complete_profile,
          context: context,
          provider: langProvider,
        );
        return false;
      }

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.verifyOtp(
          headers: headers, body: null, userId: _userId, otp: _otp);
      //*-----Calling Api End-----*

      //*-----Message to show status of the operation start----*
      _alertServices.flushBarErrorMessages(
        message: response.message.toString(),
        context: context,
        provider: langProvider,
      );
      //*-----Message to show status of the operation start----*

      _setVerificationResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setVerificationResponse = ApiResponse.error(error.toString());
      //*-----Message to show status of the operation start----*
      _alertServices.flushBarErrorMessages(
        message: error.toString(),
        context: context,
        provider: langProvider,
      );
      //*-----Message to show status of the operation End----*

      return false;
    }
  }

//*----------Otp Verification End--------*

//*----------Resend OTP Start----------*

  ApiResponse<ResendOtpModel> _resendOtpResponse = ApiResponse.none();

  ApiResponse<ResendOtpModel> get resendOtpResponse => _resendOtpResponse;

  set _setResendOtpResponse(ApiResponse<ResendOtpModel> response) {
    _resendOtpResponse = response;
    notifyListeners();
  }

  Future<bool> resendOtp({
    required BuildContext context,
    required LanguageChangeViewModel langProvider,
    String? userId,
  }) async {
    try {
      _setResendOtpResponse = ApiResponse.loading();

      //*-----Setting Values Start------*
      await _setUserId(userId);

      debugPrint(_userId);
      //*-----Setting Values End------*

      //*-----Create Headers Start-----*
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('${Constants.username}:${Constants.password}'))}';
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      };
      //*-----Create Headers End-----*

      if (_userId == null || _userId!.isEmpty) {
        _alertServices.flushBarErrorMessages(
          message: AppLocalizations.of(context)!.error_complete_profile,
          context: context,
          provider: langProvider,
        );
        return false;
      }

      //*-----Calling Api Start-----*
      final response = await _authenticationRepository.resendOtp(
          headers: headers, body: null, userId: _userId);
      //*-----Calling Api End-----*

      //*-----Message to show status of the operation start----*
      _alertServices.flushBarErrorMessages(
        message: response.message.toString(),
        context: context,
        provider: langProvider,
      );
      //*-----Message to show status of the operation start----*

      _setResendOtpResponse = ApiResponse.completed(response);

      return true;
    } catch (error) {
      debugPrint('Printing Error: $error');
      _setResendOtpResponse = ApiResponse.error(error.toString());
      //*-----Message to show status of the operation start----*
      _alertServices.flushBarErrorMessages(
        message: error.toString(),
        context: context,
        provider: langProvider,
      );
      //*-----Message to show status of the operation End----*
      return false;
    }
  }

//*----------Resend OTP End----------*
}
