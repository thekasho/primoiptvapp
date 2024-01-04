part of '../widgets.dart';

class CardSeasonItem extends StatelessWidget {
  const CardSeasonItem({
    Key? key,
    required this.number,
    required this.isSelected,
    required this.onFocused,
    required this.onTap,
  }) : super(key: key);
  final String number;
  final bool isSelected;
  final Function(bool) onFocused;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onFocusChange: onFocused,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Container(
              width: 0.3.w,
              height: 9.h,
              decoration: BoxDecoration(
                color: isSelected ? yellowStar : Colors.transparent,
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
            SizedBox(width: isSelected ? 2.w : 1.w),
            Text(
              '$number موسم ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardEpisodeItem extends StatelessWidget {
  const CardEpisodeItem(
      {Key? key,
        required this.episode,
        required this.isSelected,
        required this.onTap,
        required this.index,
        this.image
      }) : super(key: key);

  final Episode? episode;
  final bool isSelected;
  final int index;
  final Function() onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border(
          left: BorderSide(
              width: 0.04.w,
              color: white
          ),
          right: BorderSide(
              width: 0.04.w,
              color: white
          ),
          bottom: BorderSide(
              width: 0.04.w,
              color: white
          ),
          top: BorderSide(
              width: 0.04.w,
              color: white
          ),
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(2.h),
      // color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.9) ,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            onPressed: onTap,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>( bg2 ),
                              overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                states.contains(white38);
                              },),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.h),
                              )),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.circlePlay,
                                  color: white,
                                  size: 15.sp,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  "تشغيل الحلقة",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          episode!.info!.name ?? " الحلقة $index",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Text(
                              getDurationMovie(episode!.info!.duration),
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontFamily: "Cairo"
                              ),
                            ),
                            SizedBox(width: 0.5.w),
                            Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.white,
                              size: 13.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.w),
            child: CachedNetworkImage(
              width: isSelected ? 13.w : 12.w,
              height: isSelected ? 21.h : 20.h,
              imageUrl: episode!.info!.movieImage == 'null' ? image! : episode!.info!.movieImage!,
              fit: BoxFit.cover,
              placeholder: (_, i) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorWidget: (_, i, e) {
                return Container(
                  decoration: BoxDecoration(
                    color: black38,
                  ),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.image,
                      color: white54,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
