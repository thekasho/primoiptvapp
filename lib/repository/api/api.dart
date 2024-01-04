import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'package:primpiptv/repository/models/channel_movie.dart';
import 'package:primpiptv/repository/models/server.dart';

import '../models/auth.dart';
import '../models/category.dart';
import '../models/channelLive.dart';
import '../models/channel_serie.dart';
import '../models/login.dart';
import '../models/movie_detail.dart';
import '../models/serie_details.dart';
import '../models/user.dart';

part '../locale/locale.dart';
part 'auth.dart';
part 'iptv.dart';

final _dio = Dio();
final locale = GetStorage();
