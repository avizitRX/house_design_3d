import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_design_3d/provider/gallery_provider.dart';
import 'package:home_design_3d/screen/base.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GalleryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Home Design 3D',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          useMaterial3: true,
        ),
        home: const Base(),
      ),
    );
  }
}
