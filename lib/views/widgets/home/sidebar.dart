part of '../widgets.dart';

class HomeSideBar extends StatelessWidget {
  final void Function() catsOnPressed;
  final String liveBtnTitle;
  final IconData liveIcon;

  final void Function() moviesOnPressed;
  final String moviesBtnTitle;
  final IconData moviesIcon;

  final void Function() seriesOnPressed;
  final String seriesBtnTitle;
  final IconData seriesIcon;

  final void Function() settingOnPressed;
  final String settingBtnTitle;
  final IconData settingIcon;

  final void Function() accountsOnPressed;
  final String accountsBtnTitle;
  final IconData accountsIcon;

  final void Function() logOutOnPressed;
  final String logOutBtnTitle;
  final IconData logOutIcon;
  
  const HomeSideBar({
    super.key,
    required this.catsOnPressed,
    required this.liveBtnTitle,
    required this.liveIcon,
    required this.moviesOnPressed,
    required this.moviesBtnTitle,
    required this.moviesIcon,
    required this.seriesOnPressed,
    required this.seriesBtnTitle,
    required this.seriesIcon,
    required this.settingOnPressed,
    required this.settingBtnTitle,
    required this.settingIcon,
    required this.accountsOnPressed,
    required this.accountsBtnTitle,
    required this.accountsIcon,
    required this.logOutOnPressed,
    required this.logOutBtnTitle,
    required this.logOutIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4.h,
        left: 1.w,
        right: 1.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: catsOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    liveBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    liveIcon,
                    size: 15.sp,
                    color: white
                  ),
                ],
              ),
            ),
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: moviesOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty
                    .all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    moviesBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    moviesIcon,
                    size: 15.sp,
                    color: white
                  ),
                ],
              ),
            ),
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: seriesOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    seriesBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    seriesIcon,
                    size: 15.sp,
                    color: white
                  ),
                ],
              ),
            ),
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: settingOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    settingBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    settingIcon,
                    size: 15.sp,
                    color: white
                  )
                ],
              ),
            ),
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: accountsOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty
                    .all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .end,
                children: [
                  Text(
                    accountsBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    accountsIcon,
                    size: 15.sp,
                    color: white
                  ),
                ],
              ),
            ),
          ),

          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: logOutOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    logOutBtnTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: white,
                      fontFamily: 'Cairo'
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(
                    logOutIcon,
                    size: 15.sp,
                    color: white
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
