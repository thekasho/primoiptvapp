import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/auth.dart';

abstract class MacController extends GetxController {
  checkNetwork();
  loadAuth();
  reload();
}

class MacControllerImp extends MacController {
  late StatusRequest statusRequest;
  InitData initData = InitData(Get.find());
  bool isConnected = false;
  String macAddress = "";
  String userId = "";

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  loadAuth() async {
    try {
      await checkNetwork();
      if(isConnected == true) {
        final authOldData = await LocaleApi.getAuthData();
        if(authOldData != null){
          macAddress = "${authOldData.macAddress}";
          userId = "${authOldData.regId}";
          update();
        } else {
          // Get.offAllNamed(screenLanding);
        }
      } else {
        Get.defaultDialog(
            backgroundColor: blue,
            title: "خطأ",
            titlePadding: EdgeInsets.only(bottom: 2.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: white,
            ),
            content: Text(
              "لا يوجد اتصال بالانترنت",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            onWillPop: () async {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
              return false;
            }
        );
      }
    } catch(e){
      print("Error: $e");
    }
  }
  
  @override
  reload() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      
      await checkNetwork();
      if(isConnected == true) {
        var response = await initData.postData({
          "mac_address": macAddress
        });
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == 200) {
            if(response['result']['reg_statue'] == "1"){
              Map<String, dynamic> authData = {
                "macAddress": response['result']['mac_address'],
                "regId": response['result']['id'],
                "regStatue": response['result']['reg_statue'],
              };
              final authD = AuthModel.fromJson(authData);
              await LocaleApi.saveAuthData(authD.toJson());
              statusRequest = StatusRequest.success;
              update();
              Get.offAllNamed(screenHome);
            } else {
              statusRequest = StatusRequest.success;
              update();
            }
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    checkNetwork();
    loadAuth();
    super.onInit();
  }
}