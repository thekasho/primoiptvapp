part of '../widgets.dart';

class MacAppBar extends StatelessWidget {

  const MacAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackSendStar,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 10.h,
              color: bgBlackSendStar,
              child: Row(
                children: [
                  SizedBox(width: 2.w),
                  Image(
                    height: 7.h,
                    image: const AssetImage(k3dLogo),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 0.1.w,
                    height: 8.h,
                    margin: EdgeInsets.only(
                        left: 1.w,
                        right: 3.w
                    ),
                    color: yellowStar,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    kAppName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
