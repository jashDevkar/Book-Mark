import 'package:bookmark/Providers/bookmark_provider.dart';
import 'package:bookmark/constants/my_theme.dart';
import 'package:bookmark/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('bookmark');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookmarkProvider()
            ..retriveAllPlatforms()
            ..retriveAllFolders(),
        ),
      ],
      child: MaterialApp(theme: MyTheme.mytheme, home: HomePage()),
    );
  }
}






















  // void getReceiveSharingWhileAppIsClosed() async {

  //   try {

  //     final _sharedFile = <SharedMediaFile>[];
  //     await ReceiveSharingIntent.instance.getInitialMedia().then((val) {
  //       _sharedFile.clear();
  //       _sharedFile.addAll(val);
  //       List<Map<String, dynamic>> values = _sharedFile
  //           .map((f) => f.toMap())
  //           .toList();

  //       setState(() {
  //         log('updated text message');
  //         text = values[0]['path'].toString();
  //         data = null;
  //       });
  //       ReceiveSharingIntent.instance.reset();
  //     });
  //   } catch (e) {
  //     log(e.toString());
   
  //   }
  // }
