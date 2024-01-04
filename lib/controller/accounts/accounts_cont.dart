import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data.dart';
import '../../data/source/remote/call_server.dart';
import '../../data/source/remote/init_data.dart';
import '../../helpers/helpers.dart';
import '../../repository/api/api.dart';
import '../../repository/models/login.dart';
import '../../repository/models/server.dart';
import '../../repository/models/user.dart';

abstract class AccountController extends GetxController {
  checkNetwork();
  getCurrentInfo();
  addAccount();
  getAccounts();
  applyAccount(String accName);
  delAccount(String accName);
  updateLists();
}
class AccountControllerImp extends AccountController {
  InitData initData = InitData(Get.find());
  CallServer callServer = CallServer(Get.find());

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController inHost;
  late TextEditingController inPort;
  late TextEditingController inUsername;
  late TextEditingController inPassword;

  StatusRequest statusRequest = StatusRequest.none;

  String macAddress = "";
  String userId = "";
  String currentAcc = "";

  String username = "";
  String password = "";
  String createDate = "";
  String expDate = "";
  bool isConnected = false;
  List oldAcc = [];
  
  @override
  checkNetwork() async {
    isConnected = await InternetConnectionChecker().hasConnection;
  }

  @override
  getAccounts() async {
    final accounts = await LocaleApi.getAccounts();
    final server = await LocaleApi.getServerData();
    if(server != null){
      currentAcc = server.username!;
    }
    if (accounts != null) {
      oldAcc = [];
      Map oldA = {};
      Map<String, dynamic> defaultAcc = {
        "defaultAcc": {
          'host': "Default Server",
          'port': "******",
          'username': "******",
          'password': "******",
        }
      };
      oldA.addAll(defaultAcc);
      oldA.addAll(accounts);
      accounts.addAll(defaultAcc);
      oldAcc.addAll(oldA.values);
      oldAcc.map((e) => LoginModel.fromJson(e)).toList();
    } else {
      Map<String, dynamic> defaultAcc = {
        "defaultAcc": {
          'host': "Default Server",
          'port': "******",
          'username': "******",
          'password': "******",
        }
      };
      oldAcc.addAll(defaultAcc.values);
      oldAcc.map((e) => LoginModel.fromJson(e)).toList();
      print(oldAcc);
    }
  }
  
  @override
  updateLists() async{
    try {
      final user = await LocaleApi.getUser();

      if(user == null){
        Get.defaultDialog(title: "Error", middleText: "Server Error!!");
        return;
      }

      var url = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_vod_streams";
      var oldMovies = await initData.getMovies(url);
      Future waitWhile(bool liveCats, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (liveCats) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhile(oldMovies!.isNotEmpty).then((value) async => await LocaleApi.saveMoviesList(oldMovies)).then((value) => print("movies updated"));

      var urls = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_series";
      var oldSeries = await initData.getSeries(urls);
      Future waitWhiles(bool oldSeries, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (oldSeries) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhiles(oldSeries!.isNotEmpty).then((value) async => await LocaleApi.saveSeriesList(oldSeries)).then((value) => print("series updated"));

      var urlv = "${user.serverInfo!.serverUrl}/player_api.php?password=${user.userInfo!.password}&username=${user.userInfo!.username}&action=get_live_categories";
      var oldLiveCats = await initData.getLiveCats(urlv);
      Future waitWhilev(bool oldLiveCats, [Duration pollInterval = Duration.zero]) {
        var completer = Completer();
        check() {
          if (oldLiveCats) {
            completer.complete();
          } else {
            Timer(pollInterval, check);
          }
        }
        check();
        return completer.future;
      }
      await waitWhilev(oldLiveCats!.isNotEmpty).then((value) async => await LocaleApi.saveLiveCats(oldLiveCats)).then((value) => print("live cats updated"));
      update();
    } catch (e) {
      print(e);
    }
  }
  
  @override
  applyAccount(accName) async {
    statusRequest = StatusRequest.loading;
    update();
    if (!isConnected) {
      Get.defaultDialog(
        backgroundColor: blackSoundList,
        title: "خطأ",
        contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.w),
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: "Cairo",
          color: red,
        ),
        content: Text(
          "لا يوجد اتصال بالشبكة",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
          ),
        ),
      );
      statusRequest = StatusRequest.failure;
      update();
      return;
    } else {
      final accounts = await LocaleApi.getAccounts();
      if (accounts != null) {
        if(accName != "******"){
          final accHost = accounts[accName]['host'];
          final accPort = accounts[accName]['port'];
          final accUser = accounts[accName]['username'];
          final accPass = accounts[accName]['password'];
          var fetchServer = await callServer.fetchServer(accHost, accPort, accUser, accPass);
          if (StatusRequest.serverFailure == fetchServer) {
            Get.defaultDialog(
              backgroundColor: black38,
              title: "خطأ",
              titlePadding: EdgeInsets.only(bottom: 2.h),
              titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: white,
              ),
              content: Text(
                "البيانات غير صحيحة",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                ),
              ),
            );
            await getAccounts();
            statusRequest = StatusRequest.success;
            update();
          } else {
            var accountStat = fetchServer['user_info']['auth'].toString();
            if (accountStat == "0") {
              Get.defaultDialog(
                backgroundColor: black38,
                title: "خطأ",
                titlePadding: EdgeInsets.only(bottom: 2.h),
                titleStyle: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  color: white,
                ),
                content: Text(
                  "الحساب غير مفعل",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                  ),
                ),
              );
              await getAccounts();
              statusRequest = StatusRequest.success;
              update();
            } else {
              var accountValid = fetchServer['user_info']['status'].toString();
              if (accountValid != 'Active') {
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "خطأ",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "الحساب غير مفعل",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                await getAccounts();
                statusRequest = StatusRequest.success;
                update();
              } else {
                Map<String, dynamic> serverData = {
                  "domain": accHost,
                  "port": accPort,
                  "username": accUser,
                  "password": accPass,
                };
                final serverD = ServerModel.fromJson(serverData);
                await LocaleApi.saveServerData(serverD.toJson());
                var finalSave = await LocaleApi.saveUser(UserModel.fromJson(fetchServer));
                if(finalSave) {
                  Get.defaultDialog(
                    backgroundColor: black38,
                    title: "نجح",
                    titlePadding: EdgeInsets.only(bottom: 2.h),
                    titleStyle: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                      color: white,
                    ),
                    content: Text(
                      "تم تفعيل الحساب",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Cairo",
                      ),
                    ),
                  );
                  await updateLists();
                  update();
                  Get.offAllNamed(screenLanding);
                } else {
                  Get.defaultDialog(
                    backgroundColor: black38,
                    title: "خطأ",
                    titlePadding: EdgeInsets.only(bottom: 2.h),
                    titleStyle: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                      color: white,
                    ),
                    content: Text(
                      "حدث خطأ",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Cairo",
                      ),
                    ),
                  );
                  await updateLists();
                  update();
                  Get.offAllNamed(screenLanding);
                }
              }
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
                );
                await getAccounts();
                statusRequest = StatusRequest.success;
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
                    )
                );
                await getAccounts();
                statusRequest = StatusRequest.success;
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
                    )
                );
                await getAccounts();
                statusRequest = StatusRequest.success;
                update();
              } else {
                var finalSave = await LocaleApi.saveUser(UserModel.fromJson(fetchServer));
                if(finalSave){
                  Get.defaultDialog(
                    backgroundColor: black38,
                    title: "نجح",
                    titlePadding: EdgeInsets.only(bottom: 2.h),
                    titleStyle: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                      color: white,
                    ),
                    content: Text(
                      "تم تفعيل الحساب",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Cairo",
                      ),
                    ),
                  );
                  await updateLists();
                  update();
                  Get.offAllNamed(screenLanding);
                } else {
                  Get.defaultDialog(
                    backgroundColor: black38,
                    title: "خطأ",
                    titlePadding: EdgeInsets.only(bottom: 2.h),
                    titleStyle: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                      color: white,
                    ),
                    content: Text(
                      "حدث خطأ",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "Cairo",
                      ),
                    ),
                  );
                  await updateLists();
                  update();
                  Get.offAllNamed(screenLanding);
                }
              }
            }
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
              );
              await getAccounts();
              statusRequest = StatusRequest.success;
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
                  )
              );
              await getAccounts();
              statusRequest = StatusRequest.success;
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
                  )
              );
              await getAccounts();
              statusRequest = StatusRequest.success;
              update();
            } else {
              var finalSave = await LocaleApi.saveUser(UserModel.fromJson(fetchServer));
              if(finalSave){
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "نجح",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "تم تفعيل الحساب",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                await updateLists();
                update();
                Get.offAllNamed(screenLanding);
              } else {
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "خطأ",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "حدث خطأ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                await updateLists();
                update();
                Get.offAllNamed(screenLanding);
              }
            }
          }
        }
      }
    }
  }

  @override
  addAccount() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var fetchServer = await callServer.fetchServer(inHost.text, inPort.text, inUsername.text, inPassword.text);
      if (StatusRequest.serverFailure == fetchServer) {
        Get.defaultDialog(
          backgroundColor: black38,
          title: "خطأ",
          titlePadding: EdgeInsets.only(bottom: 2.h),
          titleStyle: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
            color: white,
          ),
          content: Text(
            "البيانات غير صحيحة",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
            ),
          ),
        );
      } else {
        var accountStat = fetchServer['user_info']['auth'].toString();
        if (accountStat == "0") {
          Get.defaultDialog(
            backgroundColor: black38,
            title: "خطأ",
            titlePadding: EdgeInsets.only(bottom: 2.h),
            titleStyle: TextStyle(
              fontSize: 18.sp,
              fontFamily: "Cairo",
              color: white,
            ),
            content: Text(
              "الحساب غير مفعل",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
          );
        } else {
          var accountValid = fetchServer['user_info']['status'].toString();
          if (accountValid != 'Active') {
            Get.defaultDialog(
              backgroundColor: black38,
              title: "خطأ",
              titlePadding: EdgeInsets.only(bottom: 2.h),
              titleStyle: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
                color: white,
              ),
              content: Text(
                "الحساب غير مفعل",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                ),
              ),
            );
          } else {
            final accounts = await LocaleApi.getAccounts();
            Map<String, dynamic> account = {
              inUsername.text: {
                'host': inHost.text,
                'port': inPort.text,
                'username': inUsername.text,
                'password': inPassword.text
              }
            };
            if(accounts != null){
              accounts.addAll(account);
              var saver = await LocaleApi.saveAccount(accounts);
              if(saver){
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "نجح",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "تم اضافة الحساب",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inHost.clear();
                inPort.clear();
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              } else {
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "خطأ",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "حدث خطأ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inHost.clear();
                inPort.clear();
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              }
            } else {
              var saver = await LocaleApi.saveAccount(account);
              if(saver){
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "نجح",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "تم اضافة الحساب",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inHost.clear();
                inPort.clear();
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              } else {
                Get.defaultDialog(
                  backgroundColor: black38,
                  title: "خطأ",
                  titlePadding: EdgeInsets.only(bottom: 2.h),
                  titleStyle: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Cairo",
                    color: white,
                  ),
                  content: Text(
                    "حدث خطأ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "Cairo",
                    ),
                  ),
                );
                inHost.clear();
                inPort.clear();
                inUsername.clear();
                inPassword.clear();
                await getAccounts();
                update();
              }
            }
          }
        }
      }
      statusRequest = StatusRequest.success;
      update();
    }
  }

  @override
  getCurrentInfo() async {
    statusRequest = StatusRequest.loading;
    update();
    final auth = await LocaleApi.getAuthData();
    if(auth != null){
      macAddress = auth.macAddress!;
      userId = auth.regId!;
    }
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  delAccount(accName) async {
    statusRequest = StatusRequest.loading;
    update();

    final accounts = await LocaleApi.getAccounts();
    accounts?.remove(accName);
    var saver = await LocaleApi.saveAccount(accounts);
    if(saver){
      Get.defaultDialog(
        backgroundColor: black38,
        title: "نجح",
        titlePadding: EdgeInsets.only(bottom: 2.h),
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: "Cairo",
          color: white,
        ),
        content: Text(
          "تم اضافة الحساب",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
          ),
        ),
      );
      await getAccounts();
      update();
    } else {
      Get.defaultDialog(
        backgroundColor: black38,
        title: "خطأ",
        titlePadding: EdgeInsets.only(bottom: 2.h),
        titleStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: "Cairo",
          color: white,
        ),
        content: Text(
          "حدث خطأ",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Cairo",
          ),
        ),
      );
      await getAccounts();
      update();
    }
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  void onInit() {
    checkNetwork();
    getCurrentInfo();
    getAccounts();
    inHost = TextEditingController();
    inPort = TextEditingController();
    inUsername = TextEditingController();
    inPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    inHost.dispose();
    inPort.dispose();
    inUsername.dispose();
    inPassword.dispose();
    super.dispose();
  }
}