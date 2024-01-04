part of '../screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> _live = [
      {
        'value': '0',
        'label': 'Live Player',
        'enable': false,
      },
      {
        'value': '1',
        'label': 'Primo Player',
      },
      {
        'value': '2',
        'label': 'VLC Player',
      },
      {
        'value': '3',
        'label': 'Exo Player',
      },
      {
        'value': '4',
        'label': 'Appino Player',
      },
    ];

    final List<Map<String, dynamic>> _movies = [
      {
        'value': '0',
        'label': 'Movies Player',
        'enable': false,
      },
      {
        'value': '1',
        'label': 'Primo Player',
      },
      {
        'value': '2',
        'label': 'VLC Player',
      },
      {
        'value': '3',
        'label': 'Exo Player',
      },
      {
        'value': '4',
        'label': 'Appino Player',
      },
    ];

    final List<Map<String, dynamic>> _series = [
      {
        'value': '0',
        'label': 'Series Player',
        'enable': false,
      },
      {
        'value': '1',
        'label': 'Primo Player',
      },
      {
        'value': '2',
        'label': 'VLC Player',
      },
      {
        'value': '3',
        'label': 'Exo Player',
      },
      {
        'value': '4',
        'label': 'Appino Player',
      },
    ];
    
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: blackSendStar,
          child: Column(
            children: [
              SettingsAppBar(
                username: "asdasdasd",
              ),
              SizedBox(height: 10.h),
              Container(
                width: 30.w,
                child: SelectFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: formFillColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: .5.h
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0,
                          color: formFillColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: .5,
                          color: white
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5,
                          color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5,
                          color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  initialValue: '0',
                  style: TextStyle(
                    color: white,
                    fontSize: 16.sp,
                  ),
                  items: _live,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 30.w,
                child: SelectFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: formFillColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: .5.h
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        color: formFillColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: .5,
                        color: white
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.5,
                        color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  type: SelectFormFieldType.dropdown,
                  initialValue: '0',
                  style: TextStyle(
                    color: white,
                    fontSize: 16.sp,
                  ),
                  items: _movies,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 30.w,
                child: SelectFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: formFillColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: .5.h
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0,
                          color: formFillColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: .5,
                          color: white
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5,
                          color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5,
                          color: red
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  initialValue: '0',
                  style: TextStyle(
                    color: white,
                    fontSize: 16.sp,
                  ),
                  items: _series,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
