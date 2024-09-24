import 'package:flutter/material.dart';
import 'package:movieapp/helper/tmdb/tmdb.dart';
import 'package:movieapp/views/home_screen/home_screen.dart';
import 'package:movieapp/views/offline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load movies and save them in the SQLite database
  await TmdbHelper.instance.loadMovies();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectionCheckScreen(),
    );
  }
}

class ConnectionCheckScreen extends StatefulWidget {
  const ConnectionCheckScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConnectionCheckScreenState createState() => _ConnectionCheckScreenState();
}

class _ConnectionCheckScreenState extends State<ConnectionCheckScreen> {
  bool? isOnline;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    bool connectionStatus = await TmdbHelper.instance.checkInternetConnection();
    setState(() {
      isOnline = connectionStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOnline == null) {
      return const Scaffold(
        body: Center(
            child:
                CircularProgressIndicator()), // Show loading spinner while checking connection
      );
    }
    setState(() {
      if (isOnline == true) {
        TmdbHelper.instance.loadMovies();
      }
      isOnline = !isOnline!;
    });
    return isOnline == true ? const HomeScreen() : const Offline();
  }
}
