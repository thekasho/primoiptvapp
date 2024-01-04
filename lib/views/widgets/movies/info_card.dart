part of '../widgets.dart';

class CardInfoMovie extends StatelessWidget {
  const CardInfoMovie(
      {Key? key,
        required this.hint,
        required this.title,
        required this.icon,
        this.isShowMore = false})
      : super(key: key);
  final String hint;
  final String title;
  final IconData icon;
  final bool isShowMore;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                hint,
                style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 15.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 0.5.w),
              Icon(
                icon,
                size: 15.sp,
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          !isShowMore
              ? Text(
            title,
            style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 15.sp,
              color: Colors.white,
            ),
          )
              : ReadMoreText(
            textDirection: TextDirection.rtl,
            title,
            trimLines: 2,
            colorClickableText: kColorFocus,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: 'less',
            style: TextStyle(
              fontFamily: "Cairo",
              fontSize: 15.sp,
              color: Colors.white,
            ),
            moreStyle: Get.textTheme.headlineSmall!.copyWith(
              color: yellowStar,
            ),
            lessStyle: Get.textTheme.headlineSmall!.copyWith(
              color: yellowStar,
            ),
          ),
        ],
      ),
    );
  }
}

class CardMovieImageRate extends StatelessWidget {
  const CardMovieImageRate({Key? key, required this.image, required this.rate, this.onPressed, this.favColor, this.favText})
      : super(key: key);
  final String image;
  final String rate;
  final void Function()? onPressed;
  final Color? favColor;
  final String? favText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image != "" ? CachedNetworkImage(
            imageUrl: image,
            width: 18.w,
            height: 55.h,
            fit: BoxFit.cover,
            errorWidget: (_, i, e) {
              return Container(
                color: Colors.grey,
              );
            },
          ) : Image.asset("assets/images/blank.png", width: 18.w, height: 55.h),
        ),
        SizedBox(height: 3.h),
        RatingBarIndicator(
          rating: double.tryParse(rate.toString()) ?? 0,
          itemBuilder: (context, index) => const Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 18.sp,
          direction: Axis.horizontal,
        ),
        SizedBox(height: 5.h),
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.h),
                )),
                backgroundColor: MaterialStateProperty.all<Color>( bg2 ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  states.contains(white38);
                },),
                elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
                  return 0;
                }),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(13.w, 5.h)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    favText!,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 13.sp,
                      color: favColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
