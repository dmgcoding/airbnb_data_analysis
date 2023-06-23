import 'dart:convert';

import 'package:airbnb_cost_calculator/models/req_models/cost_pred_req_model.dart';
import 'package:airbnb_cost_calculator/models/res_models/cost_pred_res_model.dart';
import 'package:airbnb_cost_calculator/services/api_service.dart';
import 'package:airbnb_cost_calculator/uis/screens/result.dart';
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
  bool get isLoading => _isLoading;

  //setters
  set setSelectedBurough(String val) => _selectedBurough = val;
  set setSelectedNeighbourhood(String val) => _selectedNeighbourhood = val;
  set setSelectedRoomType(String val) => _selectedRoomType = val;
  set setSelectedNumOfNights(int val) => _selectedNumOfNights = val;

  void resetIsLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void getPredictions(BuildContext cxt) async {
    // print("_selectedBurough: $_selectedBurough");
    // print("_selectedNeighbourhood: $_selectedNeighbourhood");
    // print("_selectedRoomType: $_selectedRoomType");
    // print("_selectedNumOfNights: $_selectedNumOfNights");

    try {
      CostPredReqModel reqModel = CostPredReqModel(
          neighbourhoodGroup: _selectedBurough,
          neighbourhood: _selectedNeighbourhood,
          roomType: _selectedRoomType,
          nights: _selectedNumOfNights);

      final res =
          await ApiService.postRequest('/pred', bodyJson: reqModel.toJson());
      if (res == null) return;

      CostPredResModel resModel = CostPredResModel.fromRawJson(res.body);
      if (resModel.pred == null && cxt.mounted) {
        print('error from api in getPredictions:');
        _isLoading = false;
        notifyListeners();
        const snackBar = SnackBar(
          content: Text('Some error from endoint'),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
      }

      final Pred? data = resModel.pred;

      if (cxt.mounted) {
        Navigator.pushReplacement(
            cxt, MaterialPageRoute(builder: (context) => ResultPreds(data!)));
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("getPredictions e: $e");
    }
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
