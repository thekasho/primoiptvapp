import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:primpiptv/repository/api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primpiptv/views/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'binding/initial_binding.dart';
import 'helpers/helpers.dart';
import 'logic/cubits/settings/settings_cubit.dart';
import 'logic/cubits/video/video_cubit.dart';


void main() async {
  await GetStorage.init();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(MyApp(
    iptv: IpTvApi(),
  ));
}

class MyApp extends StatefulWidget {
  final IpTvApi iptv;
  const MyApp({super.key, required this.iptv});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoCubit>(
          create: (BuildContext context) => VideoCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orient, type) {
          return Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: GetMaterialApp(
              title: kAppName,
              theme: MyThemApp.themeData(context),
              debugShowCheckedModeBanner: false,
              initialBinding: InitialBinding(),
              initialRoute: "/",
              getPages: [
                
                GetPage(name: screenLanding, page: () => const LandingScreen()),    // 1
                GetPage(name: screenLogin, page: () => const LoginScreen()),        // 2
                GetPage(name: screenHome, page: () => const HomeScreen()),          // 3
                GetPage(name: screenMac, page: () => const MacScreen()),          // 3    
                
              ],
            ),
          );
        }
      ),
    );
  }
}
