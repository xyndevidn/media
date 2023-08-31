import 'package:flutter/material.dart';
import 'package:media/data/api/api_service.dart';
import 'package:media/provider/upload_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'provider/home_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UploadProvider(ApiService()),
      )
    ],
    child: const MaterialApp(
      home: HomePage(),
    ),
  ));
}
