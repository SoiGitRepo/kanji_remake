import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanji_remake/page/level_page/page_level.dart';
import 'package:path_provider/path_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool initDone = false;

  Future<void> copyDatabaseFileFromAssets() async {
    // Search and create db file destination folder if not exist
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final objectBoxDirectory =
        Directory(documentsDirectory.path + '/objectbox/');

    if (!objectBoxDirectory.existsSync()) {
      await objectBoxDirectory.create(recursive: true);
    }

    final dbFile = File(objectBoxDirectory.path + '/data.mdb');
    if (!dbFile.existsSync()) {
      // Get pre-populated db file.
      ByteData data = await rootBundle.load("assets/databases/data.mdb");

      // Copying source data into destination file.
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    copyDatabaseFileFromAssets().whenComplete(() {
      setState(() {
        initDone = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initDone
        ? LevelPage()
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
