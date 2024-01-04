part of '../screens.dart';

class MacScreen extends StatefulWidget {
  const MacScreen({super.key});

  @override
  State<MacScreen> createState() => _MacScreenState();
}

class _MacScreenState extends State<MacScreen> {

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('الخروج', style: TextStyle(fontFamily: 'Cairo'),
              textDirection: TextDirection.rtl,),
            content: Text(
              'هل تريد اغلاق التطبيق؟',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Cairo",
              ),
            ),
            backgroundColor: white10,
            actions: [
              Shortcuts(
                  shortcuts: <LogicalKeySet, Intent>{
                    LogicalKeySet(
                        LogicalKeyboardKey.select): const ActivateIntent(),
                  },
                  child: MaterialButton(
                    focusElevation: 10,
                    color: white10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: const Text('لا', style: TextStyle(
                        fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.of(context).pop(false),
                  )
              ),

              Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(
                      LogicalKeyboardKey.select): const ActivateIntent(),
                },
                child: MaterialButton(
                  focusElevation: 10,
                  color: appTextColorPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: const Text('نعم', style: TextStyle(fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: black)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),

            ],
          ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MacControllerImp());
    return WillPopScope(
      onWillPop: () async {
        return showExitPopup();
      },
      child: Scaffold(
        body: Container(
          color: offlineGray,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const MacAppBar(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90.w,
                      height: 80.h,
                      decoration: const BoxDecoration(
                        color: black38,
                        boxShadow: [
                          BoxShadow(
                            color: bgBlackSendStar,
                            blurRadius: 30.0,
                            spreadRadius: 3,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 3.h),
                            child: Text(
                              "Welcome to $kAppName",
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            child: Text(
                              "Please Contact Your Provider to Register this MAC Address and upload your Playlist or visit our Website: http://primo-tv.com to activate your Mac Address.",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GetBuilder<MacControllerImp>(builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        color: buttonColor,
                                      ),
                                      width: 27.w,
                                      height: 9.h,
                                      child: TextButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                                text: controller.macAddress),
                                          );
                                        },
                                        child: Text(
                                          controller.macAddress.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        color: buttonColor,
                                      ),
                                      width: 27.w,
                                      height: 9.h,
                                      child: TextButton(
                                        isSemanticButton: false,
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                                text: controller.userId),
                                          );
                                        },
                                        child: Text(
                                          controller.userId,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                          Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 3.w),
                            child: Text(
                              "If your MAC address is 00:00:00:00:00, Please turn on your"
                                  "GPS & WIFI service to get your MAC, then press Reload Button Below..",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                          GetBuilder<MacControllerImp>(builder: (controller) {
                            return Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 2.w),
                                  width: 30.w,
                                  child: SizedBox(
                                    width: 10.w,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.reload();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: offlineGray,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                      ),
                                      child: Container(
                                        height: 9.h,
                                        alignment: Alignment.center,
                                        child: Text(
                                          controller.statusRequest == StatusRequest.loading ?
                                          "Loading" : "Reload",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Container(
                                      height: 9.h,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "userStatue" == "1"
                                            ? 'Continue'
                                            : "Check Registeration",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
