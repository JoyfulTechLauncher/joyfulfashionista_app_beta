import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/index.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414,
          896), // The size of the equipment in the design draft (the unit is arbitrary, dp is recommended, but it must be consistent during use)
      // splitScreenMode: false, // Support split screen size
      // minTextAdapt: false, // Whether to fit text according to minimum width/height
      builder: (context, child) {
        return RefreshConfiguration(
          headerBuilder: () => const ClassicHeader(), // custom refresh header
          footerBuilder: () => const ClassicFooter(), // custom refresh tail
          hideFooterWhenNotFull:
              true, // When the list is less than one page, whether to hide the refresh tail
          headerTriggerDistance: 80, // Distance to trigger refresh
          maxOverScrollExtent: 100, // Maximum drag distance
          footerTriggerDistance: 150, // Distance to trigger loading
          child: GetMaterialApp(
            title: 'Joyfulfashionista Demo',

            // style
            theme:
                ConfigService.to.isDarkModel ? AppTheme.dark : AppTheme.light,

            // router
            initialRoute: RouteNames.systemSplash,
            // initialRoute: RouteNames.stylesStylesIndex,
            getPages: RoutePages.list,
            navigatorObservers: [RoutePages.observer],

            // mutilaunguage
            translations: Translation(), // dictionary
            localizationsDelegates:
                Translation.localizationsDelegates, // localizationsDelegates
            supportedLocales: Translation.supportedLocales, // supportedLocales
            locale: ConfigService.to.locale, // locale
            fallbackLocale: Translation.fallbackLocale, // fallbackLocale

            // builder
            builder: (context, widget) {
              widget = EasyLoading.init()(context, widget); // EasyLoading

              // Does not scale with system fonts
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget,
              );
            },

            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
