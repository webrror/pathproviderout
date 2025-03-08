import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _tempDirectory = 'Unknown';
  String? _downloadsDirectory = 'Unknown';
  String? _appSupportDirectory = 'Unknown';
  String? _documentsDirectory = 'Unknown';
  String? _cacheDirectory = 'Unknown';
  String? _refreshDateTime = 'Unknown';
  String? _externalCacheDirectories = 'Unknown';
  String? _externalStorageDirectories = 'Unknown';
  String? _externalStorageDirectory = 'Unknown';
  String? _libraryDirectory = 'Unknown';

  @override
  void initState() {
    super.initState();
    initDirectories();
  }

  Future<void> initDirectories() async {
    String? tempDirectory;
    String? downloadsDirectory;
    String? appSupportDirectory;
    String? documentsDirectory;
    String? cacheDirectory;
    String? externalCacheDirectories;
    String? externalStorageDirectories;
    String? libraryDirectory;
    String? externalStorageDirectory;

    String? refreshDateTime;

    try {
      tempDirectory = (await getTemporaryDirectory()).path;
    } on UnimplementedError {
      tempDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      tempDirectory = 'Failed to get temp directory: $exception';
    }
    try {
      downloadsDirectory = (await getDownloadsDirectory())?.path;
    } on UnimplementedError {
      downloadsDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      downloadsDirectory = 'Failed to get downloads directory: $exception';
    }

    try {
      documentsDirectory = (await getApplicationDocumentsDirectory()).path;
    } on UnimplementedError {
      documentsDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      documentsDirectory = 'Failed to get documents directory: $exception';
    }

    try {
      appSupportDirectory = (await getApplicationSupportDirectory()).path;
    } on UnimplementedError {
      appSupportDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      appSupportDirectory = 'Failed to get app support directory: $exception';
    }

    try {
      cacheDirectory = (await getApplicationCacheDirectory()).path;
    } on UnimplementedError {
      cacheDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      cacheDirectory = 'Failed to get cache directory: $exception';
    }

    try {
      externalCacheDirectories = (await getExternalCacheDirectories())?.join('\n');
    } on UnimplementedError {
      externalCacheDirectories = 'Method not implemented on this platform';
    } catch (exception) {
      externalCacheDirectories = 'Failed to get external cache directories: $exception';
    }

    try {
      externalStorageDirectories = "Alarms: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.alarms))?.join('\n') ?? '');

      externalStorageDirectories += "\nDownloads: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.downloads))?.join('\n') ?? '');

      externalStorageDirectories += "\nMusic: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.music))?.join('\n') ?? '');

      externalStorageDirectories += "\nMovies: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.movies))?.join('\n') ?? '');

      externalStorageDirectories += "\nNotifications: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.notifications))?.join('\n') ?? '');

      externalStorageDirectories += "\nPictures: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.pictures))?.join('\n') ?? '');

      externalStorageDirectories += "\nPodcasts: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.podcasts))?.join('\n') ?? '');

      externalStorageDirectories += "\nRingtones: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.ringtones))?.join('\n') ?? '');

      externalStorageDirectories += "\nDCIM: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.dcim))?.join('\n') ?? '');

      externalStorageDirectories += "\nDocuments: ";
      externalStorageDirectories = externalStorageDirectories + ((await getExternalStorageDirectories(type: StorageDirectory.documents))?.join('\n') ?? '');
    } on UnimplementedError {
      externalStorageDirectories = 'Method not implemented on this platform';
    } catch (exception) {
      externalStorageDirectories = 'Failed to get external storage directories: $exception';
    }

    try {
      libraryDirectory = (await getLibraryDirectory()).path;
    } on UnimplementedError {
      libraryDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      libraryDirectory = 'Failed to get library directory: $exception';
    }

    try {
      externalStorageDirectory = (await getExternalStorageDirectory())?.path;
    } on UnimplementedError {
      externalStorageDirectory = 'Method not implemented on this platform';
    } catch (exception) {
      externalStorageDirectory = 'Failed to get external storage directory: $exception';
    }

    refreshDateTime = DateFormat('dd MMM yyyy \'at\' hh:mm:ss a').format(DateTime.now());

    setState(() {
      _tempDirectory = tempDirectory;
      _downloadsDirectory = downloadsDirectory;
      _appSupportDirectory = appSupportDirectory;
      _documentsDirectory = documentsDirectory;
      _cacheDirectory = cacheDirectory;
      _refreshDateTime = refreshDateTime;
      _externalCacheDirectories = externalCacheDirectories;
      _externalStorageDirectories = externalStorageDirectories;
      _libraryDirectory = libraryDirectory;
      _externalStorageDirectory = externalStorageDirectory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Path Provider Outputs')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Data last updated: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      WidgetSpan(child: Row(children: [SelectableText(_refreshDateTime ?? "-"), IconButton(onPressed: () => initDirectories(), icon: const Icon(Icons.refresh))])),
                    ],
                  ),
                ),
                Text.rich(TextSpan(children: [TextSpan(text: 'Temp Directory [getTemporaryDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_tempDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'Documents Directory [getApplicationDocumentsDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_documentsDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'Downloads Directory [getDownloadsDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_downloadsDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'Application Support Directory [getApplicationSupportDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_appSupportDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'Cache Directory [getApplicationCacheDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_cacheDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'External Cache Directories [getExternalCacheDirectories()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_externalCacheDirectories ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'External Storage Directories [getExternalStorageDirectories()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_externalStorageDirectories ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'External Storage Directory [getExternalStorageDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_externalStorageDirectory ?? "-"))])),
                Text.rich(TextSpan(children: [TextSpan(text: 'Library Directory [getLibraryDirectory()]: ', style: TextStyle(fontWeight: FontWeight.bold)), WidgetSpan(child: SelectableText(_libraryDirectory ?? "-"))])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
