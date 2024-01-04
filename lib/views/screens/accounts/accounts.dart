part of '../screens.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  AccountControllerImp accountControllerImp = Get.put(AccountControllerImp());

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: GetBuilder<AccountControllerImp>(builder: (accountController) {
        if (accountController.statusRequest == StatusRequest.success) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: blackSendStar,
              child: Column(
                children: [
                  SettingsAppBar(
                    username: accountController.macAddress,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        
                        Container(
                          width: 50.w,
                          height: 90.h,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1,
                                  color: blackSoundList
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "الحسابات المسجلة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Ink(
                                width: 45.w,
                                height: 81.h,
                                padding: EdgeInsets.all(0.4.w),
                                child: NestedScrollView(
                                  headerSliverBuilder: (_, ch) {
                                    return [];
                                  },
                                  body: GetBuilder<AccountControllerImp>(
                                      builder: (accController) {
                                        return HandleRequest(
                                          statusRequest: accController.statusRequest,
                                          widget: GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(
                                              bottom: 10.h,
                                            ),
                                            itemCount: accController.oldAcc.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              mainAxisSpacing: 2.h,
                                              mainAxisExtent: 17.h,
                                            ),
                                            itemBuilder: (_, i) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  color: black12,
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: white
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              SizedBox(
                                                                width: 4.w,
                                                                child: Shortcuts(
                                                                  shortcuts: <LogicalKeySet, Intent>{
                                                                    LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                                  },
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      accountController.applyAccount(accController.oldAcc[i]['username']);
                                                                    },
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(black54),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                                                      ),
                                                                      elevation: MaterialStateProperty.all(0),
                                                                      overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                                                        states.contains(white38);
                                                                        return null;
                                                                      }),
                                                                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.task_alt,
                                                                      color: googleColor,
                                                                      size: 2.w
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: .5.w),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              accController.oldAcc[i]['host'] != "Default Server" ?
                                                              SizedBox(
                                                                width: 4.w,
                                                                child: Shortcuts(shortcuts: <LogicalKeySet, Intent>{
                                                                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
                                                                  },
                                                                  child: ElevatedButton(
                                                                    onPressed: () async {
                                                                      await showDialog(
                                                                        context: context,
                                                                        builder: (context) => AlertDialog(
                                                                          title: const Text('حذف الحساب', style: TextStyle(fontFamily: 'Cairo'), textDirection: TextDirection.rtl),
                                                                          content: Text(
                                                                            'هل تريد حذف الحساب ؟',
                                                                            style: TextStyle(
                                                                              fontSize: 18.sp,
                                                                              fontFamily: "Cairo",
                                                                            ),
                                                                          ),
                                                                          backgroundColor: black38,
                                                                          actions:[
                                                                            Shortcuts(
                                                                                shortcuts: <LogicalKeySet, Intent>{
                                                                                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                                                },
                                                                                child: MaterialButton(
                                                                                  focusElevation: 10,
                                                                                  color: white10,
                                                                                  shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(20.0)
                                                                                  ),
                                                                                  child: const Text('لا', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                    accController.update();
                                                                                  },
                                                                                )
                                                                            ),
                                                                            Shortcuts(
                                                                              shortcuts: <LogicalKeySet, Intent>{
                                                                                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                                                              },
                                                                              child: MaterialButton(
                                                                                focusElevation: 10,
                                                                                color: appTextColorPrimary,
                                                                                shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20.0)
                                                                                ),
                                                                                child: const Text('نعم', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: black)),
                                                                                onPressed: () async {
                                                                                  await accController.delAccount(accController.oldAcc[i]['username']);
                                                                                }
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(black54),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                                                      ),
                                                                      elevation: MaterialStateProperty.all(0),
                                                                      overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {states.contains(white38);
                                                                      }),
                                                                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.delete_rounded,
                                                                      color: red,
                                                                      size: 2.w
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                              : const SizedBox(),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 3,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          border: Border(
                                                            left: BorderSide(
                                                              width: 0.5,
                                                              color: white
                                                            ),
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                          right: 1.w,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              flex: 9,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Text(
                                                                        "${accController.oldAcc[i]['host']}",
                                                                        style: TextStyle(
                                                                          color: white,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        " : Host",
                                                                        style: TextStyle(
                                                                          color: black,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Text(
                                                                        "${accController.oldAcc[i]['port']}",
                                                                        style: TextStyle(
                                                                          color: white,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        " : Port",
                                                                        style: TextStyle(
                                                                          color: black,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Text(
                                                                        "${accController.oldAcc[i]['username']}",
                                                                        style: TextStyle(
                                                                          color: white,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        " : User",
                                                                        style: TextStyle(
                                                                          color: black,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      Text(
                                                                        "${accController.oldAcc[i]['password']}",
                                                                        style: TextStyle(
                                                                          color: white,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        " : Pass",
                                                                        style: TextStyle(
                                                                          color: black,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Cairo',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(width: .8.w),
                                                            Flexible(
                                                              flex: 1,
                                                              child: Container(
                                                                height: 7.h,
                                                                alignment: Alignment
                                                                    .center,
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            10)),
                                                                    color: black54
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    left: 0.5.w
                                                                ),
                                                                child: Text(
                                                                  "${i + 1}",
                                                                  style: TextStyle(
                                                                    color: white,
                                                                    fontSize: 15
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                    fontFamily: 'Cairo',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 50.w,
                              margin: EdgeInsets.only(bottom: 2.h),
                              alignment: Alignment.center,
                              child: Text(
                                "الحساب الحالي",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 47.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1,
                                            color: blackSoundList
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 1.w,
                                          left: 1.w,
                                          top: 2.h,
                                          bottom: 2.h
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 1.w
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            accountController
                                                                .userId,
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : User Id",
                                                            style: TextStyle(
                                                              color: blackSoundList,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      width: 0.04.w,
                                                      color: white
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text(
                                                            accountController
                                                                .macAddress,
                                                            style: TextStyle(
                                                              color: white,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                          Text(
                                                            " : Mac Address",
                                                            style: TextStyle(
                                                              color: blackSoundList,
                                                              fontSize: 13.sp,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 50.w,
                              margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                              alignment: Alignment.center,
                              child: Text(
                                "اضافة حساب جديد",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 47.w,
                              height: 63.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color: black
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 1.w,
                                          left: 1.w,
                                          top: 3.h,
                                          bottom: 3.h
                                      ),
                                      child: GetBuilder<AccountControllerImp>(
                                        builder: (accountController) {
                                          return Form(
                                            key: accountControllerImp.formState,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: MediaQuery
                                                        .of(context)
                                                        .viewInsets
                                                        .bottom),
                                                child: Column(
                                                  children: [
                                                    AccountTextForm(
                                                      controller: accountController
                                                          .inHost,
                                                      hintText: "Host",
                                                      valid: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Host Required !!";
                                                        }
                                                      },
                                                      prefixIcon: Icon(
                                                          Icons.language,
                                                          size: 14.sp
                                                      ),
                                                      prefixIconColor: MaterialStateColor
                                                          .resolveWith((
                                                          states) =>
                                                      states.contains(
                                                          MaterialState.focused)
                                                          ? darkBck
                                                          : white
                                                      ),
                                                      focusNode: f1,
                                                      onFieldSubmitted: (val) {
                                                        f1.unfocus();
                                                        FocusScope.of(context)
                                                            .requestFocus(f2);
                                                      },
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AccountTextForm(
                                                      controller: accountController
                                                          .inPort,
                                                      hintText: "Port",
                                                      valid: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Port Required !!";
                                                        }
                                                      },
                                                      prefixIcon: Icon(
                                                          Icons
                                                              .fiber_smart_record_outlined,
                                                          size: 14.sp
                                                      ),
                                                      prefixIconColor: MaterialStateColor
                                                          .resolveWith((
                                                          states) =>
                                                      states.contains(
                                                          MaterialState.focused)
                                                          ? darkBck
                                                          : white
                                                      ),
                                                      focusNode: f2,
                                                      onFieldSubmitted: (val) {
                                                        f2.unfocus();
                                                        FocusScope.of(context)
                                                            .requestFocus(f3);
                                                      },
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AccountTextForm(
                                                      controller: accountController
                                                          .inUsername,
                                                      hintText: "Username",
                                                      valid: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Username Required !!";
                                                        }
                                                        return null;
                                                      },
                                                      prefixIcon: Icon(
                                                          FontAwesomeIcons.user,
                                                          size: 14.sp
                                                      ),
                                                      prefixIconColor: MaterialStateColor
                                                          .resolveWith((
                                                          states) =>
                                                      states.contains(
                                                          MaterialState.focused)
                                                          ? darkBck
                                                          : white
                                                      ),
                                                      focusNode: f3,
                                                      onFieldSubmitted: (val) {
                                                        f3.unfocus();
                                                        FocusScope.of(context)
                                                            .requestFocus(f4);
                                                      },
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AccountTextForm(
                                                      controller: accountController
                                                          .inPassword,
                                                      hintText: "كلمة المرور",
                                                      valid: (val) {
                                                        if (val!.isEmpty) {
                                                          return "كلمة المرور مطلوبة";
                                                        }
                                                      },
                                                      prefixIcon: Icon(
                                                          FontAwesomeIcons.lock,
                                                          size: 14.sp
                                                      ),
                                                      prefixIconColor: MaterialStateColor
                                                          .resolveWith((
                                                          states) =>
                                                      states.contains(
                                                          MaterialState.focused)
                                                          ? darkBck
                                                          : white
                                                      ),
                                                      focusNode: f4,
                                                      onFieldSubmitted: (val) {
                                                        f4.unfocus();
                                                        FocusScope.of(context)
                                                            .requestFocus(f5);
                                                        // controller.loginUser();
                                                      },
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    AccountSubmitButton(
                                                      focusNode: f5,
                                                      title: "حفظ الحساب",
                                                      onPressed: () async {
                                                        await accountController
                                                            .addAccount();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              color: offlineGray,
              height: double.infinity,
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  CircularProgressIndicator(
                    color: appTextColorPrimary,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
