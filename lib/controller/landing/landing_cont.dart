import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:primpiptv/repository/models/auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/server.dart';
import '../../repository/models/user.dart';

abstract class LandnigController extends GetxController {
  handleMacAddress();
  checkMacAddress();
  checkNetwork();
  getServerData();
}

class LandingControllerImp extends LandnigController {
  
  final NetworkInfo _networkInfo = NetworkInfo();
  late LocationPermission permission;
  late StatusRequest statusRequest;
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());
  
  String macAddress = "02:00:00:00:00:00";
  String userId = "00000000";
  String userStatue = "0";
  bool serviceEnabled = false;
  bool isConnected = false;

  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }
  
  @override
  getServerData() async {
    try {
      await checkNetwork();
      if(isConnected == true) {
        final serverOldData = await LocaleApi.getServerData();
        if(serverOldData != null){
          var fetchServer = await callServer.fetchServer(serverOldData.domain, serverOldData.port, serverOldData.username, serverOldData.password);
          if(StatusRequest.serverFailure == fetchServer){
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
                "السيرفر غير متاح حاليا",
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
            await LocaleApi.removeServerData();
            update();
          } else if(fetchServer['user_info']['auth'].toString() == "0"){
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
                  "السيرفر غير متاح حاليا",
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
            await LocaleApi.removeServerData();
            update();
          } else if(fetchServer['user_info']['status'].toString() != "Active"){
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
                  "السيرفر غير متاح حاليا",
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
            await LocaleApi.removeServerData();
            update();
          } else {
            var finalSave = await LocaleApi.saveUser(UserModel.fromJson(fetchServer));
            if(finalSave){
              update();
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
                    "السيرفر غير متاح حاليا",
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
              await LocaleApi.removeServerData();
              update();
            }
          }
        } else {
          var srv_response = await initData.getServerData({
            "auth_token": "6f7964f85371cfe792e1b3286f865efb",
          });
          statusRequest = handlingData(srv_response);
          update();
          if (StatusRequest.success == statusRequest) {
            if (srv_response['status'] == 200) {
              Map<String, dynamic> serverData = {
                "domain": srv_response['result']['domain'],
                "port": srv_response['result']['port'],
                "username": srv_response['result']['username'],
                "password": srv_response['result']['password'],
              };
              final serverD = ServerModel.fromJson(serverData);
              await LocaleApi.saveServerData(serverD.toJson());

              var fetchServer = await callServer.fetchServer(serverD.domain, serverD.port, serverD.username, serverD.password);
              if(StatusRequest.serverFailure == fetchServer){
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
                      "السيرفر غير متاح حاليا",
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
                await LocaleApi.removeServerData();
                update();
              } else if(fetchServer['user_info']['auth'].toString() == "0"){
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
                      "السيرفر غير متاح حاليا",
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
                await LocaleApi.removeServerData();
                update();
              } else if(fetchServer['user_info']['status'].toString() != "Active"){
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
                      "السيرفر غير متاح حاليا",
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
                await LocaleApi.removeServerData();
                update();
              } else {
                var finalSave = await LocaleApi.saveUser(UserModel.fromJson(fetchServer));
                if(finalSave){
                  update();
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
                        "السيرفر غير متاح حاليا",
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
                  await LocaleApi.removeServerData();
                  update();
                }
              }
            }
          }
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
        await LocaleApi.removeServerData();
        update();
      }
    } catch(e){
      print("Error: $e");
    }
  }
  
  @override
  checkMacAddress() async {
    try {
      await checkNetwork();
      update();
      if(isConnected == true) {
        final authOldData = await LocaleApi.getAuthData();
        if(authOldData != null){
          update();
          if(authOldData.regStatue == "0"){
            FlutterNativeSplash.remove();
            Get.offAllNamed(screenMac);
          } else {
            FlutterNativeSplash.remove();
            Get.offAllNamed(screenHome);
          }
        } else {
          await handleMacAddress();
          update();
          if (macAddress != "02:00:00:00:00:00") {
            var response = await initData.postData({
              "mac_address": macAddress
            });
            statusRequest = handlingData(response);
            update();
            if (StatusRequest.success == statusRequest) {
              if (response['status'] == 200) {
                Map<String, dynamic> authData = {
                  "macAddress": response['result']['mac_address'],
                  "regId": response['result']['id'],
                  "regStatue": response['result']['reg_statue'],
                };
                final authD = AuthModel.fromJson(authData);
                var saveAuth = await LocaleApi.saveAuthData(authD.toJson());
                if(saveAuth && response['result']['reg_statue'] == "0"){
                  FlutterNativeSplash.remove();
                  Get.offAllNamed(screenMac);                  
                } else {
                  FlutterNativeSplash.remove();
                  Get.offAllNamed(screenHome);
                }
                update();
              }
            }
          }
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
        update();
      }
    } catch(e) {
      print("Error: $e");
    }
  }

  @override
  handleMacAddress() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.locationWhenInUse,
        Permission.location,
      ].request();
      update();
      var finalGr = await Permission.locationWhenInUse.request().isGranted;
      var finalGra = await await Permission.location.request().isGranted;
      if(finalGr && finalGra){
        if (!kIsWeb && Platform.isIOS) {
          var status = await _networkInfo.getLocationServiceAuthorization();
          if (status == LocationAuthorizationStatus.notDetermined) {
            status = await _networkInfo.requestLocationServiceAuthorization();
          }
          if (status == LocationAuthorizationStatus.authorizedAlways ||
              status == LocationAuthorizationStatus.authorizedWhenInUse) {
            macAddress =
            (await _networkInfo.getWifiBSSID() ?? "02:00:00:00:00:00");
            update();
          } else {
            macAddress =
            (await _networkInfo.getWifiBSSID() ?? "02:00:00:00:00:00");
            update();
          }
        } else {
          macAddress = await _networkInfo.getWifiBSSID() ?? "02:00:00:00:00:00";
          if (macAddress == "02:00:00:00:00:00") {
            serviceEnabled = await Geolocator.isLocationServiceEnabled();
            if (!serviceEnabled) {
              await Geolocator.getCurrentPosition().then((value) => update());
              var wifistatus = await WiFiForIoTPlugin.isEnabled();
              if (!wifistatus) {
                Get.snackbar("Error", "Please Turn On WIFI first..");
                await Future.delayed(const Duration(seconds: 2));
                await WiFiForIoTPlugin.setEnabled(
                  true,
                  shouldOpenSettings: true
                );
                update();
              }
            }
          }
        }
      }
      update();
    } catch(e) {
      print("Error: $e");
    }
  }
  
  @override
  void onInit() {
    statusRequest = StatusRequest.none;
    getServerData();
    checkMacAddress();
    checkNetwork();
    super.onInit();
  }
  
}