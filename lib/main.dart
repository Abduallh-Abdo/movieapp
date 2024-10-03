import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/app_cubit/app_cubit.dart';
import 'package:movieapp/views/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..loadMovies(),
      // ..loadGeners(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        //ConnectionCheckScreen()
        home: HomeScreen(),
      ),
    );
  }
}

// class ConnectionCheckScreen extends StatelessWidget {
//   const ConnectionCheckScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (isOnline == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//     setState(() {
//       if (isOnline == true) {
//         TmdbHelper.instance.loadMovies();
//       }
//       isOnline = !isOnline!;
//     });
//     return const HomeScreen();
//     //isOnline == false ? const HomeScreen() : const Offline()
//   }
// }
