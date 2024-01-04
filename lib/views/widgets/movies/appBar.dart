part of '../widgets.dart';

class AppBarMovies extends StatefulWidget {
  const AppBarMovies({Key? key, this.onSearch}) : super(key: key);
  final Function(String)? onSearch;

  @override
  State<AppBarMovies> createState() => _AppBarMoviesState();
}

class _AppBarMoviesState extends State<AppBarMovies> {
  bool showSearch = false;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 9.h,
      decoration: BoxDecoration(
        color: bgBlackSendStar,
        border: Border(
          bottom: BorderSide(
            width: 0.13.w,
            // color: kColorPrimaryDark
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 6.w,
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                  elevation:
                  MaterialStateProperty.all(0),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.transparent
                  ),
                ),
                child: Icon(
                    Icons.arrow_back_ios,
                    color: white, size: 3.w
                ),
              ),
            ),
          ),
          Container(
            width: 0.1.w,
            height: 8.h,
            margin: EdgeInsets.only(
                left: 1.w,
                right: 3.w
            ),
            color: white,
          ),
          Image(
            height: 7.h,
            image: const AssetImage(k3dLogo),
          ),
          const Spacer(),
          SizedBox(
            width: 6.w,
            height: 100.h,
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  elevation:
                  MaterialStateProperty.all(0),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.transparent
                  ),
                ),
                child: Icon(
                  Icons.search,
                  color: white,
                  size: 3.w
                ),
              ),
            ),
          ),
          SizedBox(
            width: 6.w,
            child: MaterialButton(
              onPressed: () {  },
              child: Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                },
                child: PopupMenuButton(
                  color: black87,
                  padding: EdgeInsets.all(0),
                  onSelected: (val){
                    return val;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  offset: Offset(-58.w, 25.h),
                  icon: Icon(
                    FontAwesomeIcons.ellipsisVertical,
                    color: white,
                    size: 3.w,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 30.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: black54,
                              border: Border(
                                bottom: BorderSide(
                                    width: 0.1.w,
                                    color: white
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "اختر المشغل",
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: white
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Icon(
                                  FontAwesomeIcons.play,
                                  color: white,
                                  size: 2.w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: (){},
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30.w,
                            height: 8.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tiatro Player",
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: (){},
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30.w,
                            height: 8.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "المشغل 2",
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}