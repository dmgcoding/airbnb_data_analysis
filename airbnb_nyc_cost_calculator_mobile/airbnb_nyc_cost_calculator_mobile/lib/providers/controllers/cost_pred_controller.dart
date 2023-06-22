import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CostPredController extends ChangeNotifier {
  SharedPreferences pref;

  CostPredController(this.pref);

  bool _isLoading = false;

  String _selectedBurough = '';
  String _selectedNeighbourhood = '';
  String _selectedRoomType = '';
  int _selectedNumOfNights = 1;

  // //getters
  String get selectedBurough => _selectedBurough;
  String get selectedNeighbourhood => _selectedNeighbourhood;
  String get selectedRoomType => _selectedRoomType;
  int get selectedNumOfNights => _selectedNumOfNights;

  //setters
  set setSelectedBurough(String val) => _selectedBurough = val;
  set setSelectedNeighbourhood(String val) => _selectedNeighbourhood = val;
  set setSelectedRoomType(String val) => _selectedRoomType = val;
  set setSelectedNumOfNights(int val) => _selectedNumOfNights = val;

  void resetIsLoading() {
    _isLoading = false;
    notifyListeners();
  }

  // void sendOtp(BuildContext cxt, SendOtpReqModel? reqModel) async {
  //   bool resend = false;
  //   if (reqModel == null) {
  //     resend = true;
  //     //for resend otp
  //     if (_sendOtpEmail != null) {
  //       reqModel = SendOtpReqModel(email: _sendOtpEmail!);
  //     } else {
  //       return showSnackBar(cxt, "No email is saved to resend otp request.");
  //     }
  //   }
  //   _sendOtpEmail = reqModel.email; //save email in state to use for resend

  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final bodyJson = reqModel.toJson();
  //     final res =
  //         await ApiService.postRequest(ApiPaths.sendOtp, bodyJson: bodyJson);

  //     if (res == null) return;
  //     SendOtpResModel resModel = sendOtpResFromJson(res.body);
  //     if (resModel.isError && cxt.mounted) {
  //       print('error from api in send otp: ${resModel.msg}');
  //       _isLoading = false;
  //       notifyListeners();
  //       return showSnackBar(cxt, resModel.msg);
  //     }

  //     final otpData = resModel.data;
  //     if (otpData == null) {
  //       _isLoading = false;
  //       notifyListeners();
  //       return;
  //     }
  //     _isLoading = false;
  //     notifyListeners();
  //     //set session key and redirect to otp verification
  //     _sendOtpSessionKey = otpData.sessionKey;
  //     if (cxt.mounted) {
  //       if (resend) {
  //         showSnackBar(cxt, 'OTP code resent to the email. Check your email.');
  //       } else {
  //         showSnackBar(cxt,
  //             "Otp is sent to your email. Enter that otp in otp verification screen.");
  //       }
  //     }
  //     locator<NavigationService>().navigateTo(router.Router.otpVerification);
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     print("send otp e: $e");
  //     if (cxt.mounted) showSnackBar(cxt, e.toString());
  //   }
  // }
}
