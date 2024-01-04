import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:primpiptv/controller/auth/mac_cont.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:select_form_field/select_form_field.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import 'package:primpiptv/core/class/statusrequest.dart';

import '../../controller/accounts/accounts_cont.dart';
import '../../controller/auth/login_cont.dart';
import '../../controller/categories/cats_cont.dart';
import '../../controller/landing/landing_cont.dart';
import '../../controller/home/home_cont.dart';

import '../../controller/live/live_cats_cont.dart';
import '../../controller/live/live_channels_cont.dart';
import '../../controller/movies/moveis_cats_cont.dart';
import '../../controller/movies/movies_channels_cont.dart';
import '../../controller/movies/movies_details_cont.dart';
import '../../controller/series/series_cats_cont.dart';
import '../../controller/series/series_channels_cont.dart';
import '../../controller/series/series_details_cont.dart';
import '../../logic/cubits/video/video_cubit.dart';
import '../../repository/models/movie_detail.dart';
import '../../repository/models/serie_details.dart';
import '../widgets/widgets.dart';
import '../../helpers/helpers.dart';
import '../../core/class/handling_data.dart';


part 'landing/landing.dart';
part 'register/mac.dart';
part 'home/home.dart';
part 'categories/cats.dart';

part 'movies/movie_details.dart';

part 'series/series_details.dart';
part 'series/series_sessons.dart';

part 'accounts/accounts.dart';

part 'settings/settings.dart';

part 'auth/login.dart';
part 'players/appino_player.dart';
part 'players/chewie_player.dart';
part 'players/full_video.dart';
part 'players/mini_player.dart';
part 'players/player_video.dart';