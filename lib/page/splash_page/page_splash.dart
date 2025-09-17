import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/page/level_page/page_level.dart';
import 'package:path_provider/path_provider.dart';

// Define a provider for the database initialization state
final databaseInitializationProvider = FutureProvider<void>((ref) async {
  return copyDatabaseFileFromAssets();
});

Future<void> copyDatabaseFileFromAssets() async {
  // Search and create db file destination folder if not exist
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final objectBoxDirectory = Directory('${documentsDirectory.path}/objectbox/');

  if (!objectBoxDirectory.existsSync()) {
    await objectBoxDirectory.create(recursive: true);
  }

  final dbFile = File('${objectBoxDirectory.path}/data.mdb');
  if (!dbFile.existsSync()) {
    // Get pre-populated db file.
    final data = await rootBundle.load('assets/databases/data.mdb');

    // Copying source data into destination file.
    await dbFile.writeAsBytes(data.buffer.asUint8List());
  }
  await Future.delayed(const Duration(seconds: 1));
}

class SplashPage extends HookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initState = ref.watch(databaseInitializationProvider);
    
    return initState.when(
      data: (_) => const LevelPage(),
      loading: () => const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('初始化中...', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text('初始化错误: ${error.toString()}', style: TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => ref.refresh(databaseInitializationProvider),
                child: Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
