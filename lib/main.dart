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
  Map<String, String> _directories = {};
  String? _refreshDateTime = 'Unknown';

  @override
  void initState() {
    super.initState();
    initDirectories();
  }

  Future<void> initDirectories() async {
    final directories = {
      'Temp Directory [getTemporaryDirectory()]': () async => (await getTemporaryDirectory()).path,
      'Documents Directory [getApplicationDocumentsDirectory()]': () async => (await getApplicationDocumentsDirectory()).path,
      'Downloads Directory [getDownloadsDirectory()]': () async => (await getDownloadsDirectory())?.path,
      'Application Support Directory [getApplicationSupportDirectory()]': () async => (await getApplicationSupportDirectory()).path,
      'Cache Directory [getApplicationCacheDirectory()]': () async => (await getApplicationCacheDirectory()).path,
      'External Cache Directories [getExternalCacheDirectories()]': () async => (await getExternalCacheDirectories())?.join('\n'),
      'External Storage Directory [getExternalStorageDirectory()]': () async => (await getExternalStorageDirectory())?.path,
      'Library Directory [getLibraryDirectory()]': () async => (await getLibraryDirectory()).path,
      'External Storage Directories [getExternalStorageDirectories()]': _fetchExternalStorageDirectories,
    };

    Map<String, String> fetchedDirectories = {};

    try {
      await Future.wait(
        directories.entries.map((entry) async {
          try {
            fetchedDirectories[entry.key] = (await entry.value() ?? "-");
          } catch (e) {
            fetchedDirectories[entry.key] = 'Failed: $e';
          }
        }),
      );
    } catch (e) {
      debugPrint('Error fetching directories: $e');
    }

    final refreshDateTime = DateFormat('dd MMM yyyy \'at\' hh:mm:ss a').format(DateTime.now());

    setState(() {
      _directories = fetchedDirectories;
      _refreshDateTime = refreshDateTime;
    });
  }

  Future<String> _fetchExternalStorageDirectories() async {
    StringBuffer storageDirectories = StringBuffer();
    for(StorageDirectory directory in StorageDirectory.values) {
      final directories = await getExternalStorageDirectories(type: directory);
      storageDirectories.write('${directory.name}: ${directories?.join('\n') ?? 'None'}\n');
    }
    return storageDirectories.toString();
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
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Text('Data last updated: ', style: TextStyle(fontWeight: FontWeight.bold)), SelectableText(_refreshDateTime ?? "-"), IconButton(onPressed: initDirectories, icon: const Icon(Icons.refresh))]),
                  ..._directories.entries.map(
                    (entry) =>
                        Padding(padding: const EdgeInsets.only(top: 8.0), child: RichText(text: TextSpan(text: '${entry.key}: ', style: const TextStyle(fontWeight: FontWeight.bold), children: [WidgetSpan(child: SelectableText(entry.value, style: const TextStyle(fontWeight: FontWeight.normal)))]))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
