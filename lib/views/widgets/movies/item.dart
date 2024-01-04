part of '../widgets.dart';

class CardChannelMovieItem extends StatelessWidget {
  const CardChannelMovieItem(
      {Key? key, required this.onTap, this.title, this.image})
      : super(key: key);
  final Function() onTap;
  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                blue
            ),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.transparent
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: 0.3.w,
              vertical: 00.3.w,
            )),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 33.8.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1.w),
                        bottomLeft: Radius.circular(1.w),
                        bottomRight: Radius.circular(1.w),
                        topRight: Radius.circular(1.w),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image ?? "assets/images/blank.png",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        errorWidget: (_, i, e) {
                          return Container(
                              color: black12,
                              height: 100.h,
                              child: Image.asset(
                                "assets/images/blank.png",
                              )
                          );
                        },
                        placeholder: (_, i) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: appTextColorPrimary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.w),
                      color: offlineGray.withOpacity(0.6),
                    ),
                    alignment: Alignment.center,
                    width: 100.w,
                    child: Text(
                      title ?? 'null',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontFamily: "Cairo"
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
