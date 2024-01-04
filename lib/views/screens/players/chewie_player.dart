part of '../screens.dart';

class ChewiePlayer extends StatefulWidget {
  const ChewiePlayer({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<ChewiePlayer> createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {

  late VideoPlayerController videoPlayerController;
  late ChewieController _chewieController;

  bool isPlayed = true;
  bool progress = true;

  bool _onKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;
    
    if (event is KeyDownEvent) {
      _chewieController.videoPlayerController.play();
    } else if (event is KeyUpEvent) {

    } else if (event is KeyRepeatEvent) {

    }
    
    return false;
  }

  @override
  void initState() {
    print(widget.link);
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.link))
      ..initialize().then((value) => setState(() {
        videoPlayerController.play();
      }));
    _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        aspectRatio: 16 / 9,
        looping: true,
        fullScreenByDefault: true,
        autoInitialize: true,
        allowFullScreen: false
    );
    videoPlayerController.addListener(listener);
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  void listener() async {
    if (!mounted) return;

    if (progress) {
      if (videoPlayerController.value.isPlaying) {
        setState(() {
          progress = false;
        });
      }
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.black,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          if (progress)
            const Center(
                child: CircularProgressIndicator(
                  color: yellowStar,
                )),
        ],
      ),
    );
  }
}
