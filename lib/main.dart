import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_apps/blocs/movie/movie_bloc.dart';
import 'package:movie_apps/blocs/movie/movie_event.dart';
import 'package:movie_apps/data/app_repository.dart';
import 'package:movie_apps/data/app_services.dart';
import 'package:movie_apps/pages/splash_page.dart';
import 'package:movie_apps/utils/bloc_observer.dart';

import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final w700BitterFont = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
  );
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(services: AppServices()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(
              repository: context.read<AppRepository>(),
            )..add(GetMovies()),
          )
        ],
        child: MaterialApp(
          title: 'Movie Apps by Ky',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppColors.primary,
            primaryColor: AppColors.primary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: AppColors.secondary,
                  primary: AppColors.primary,
                ),
            scaffoldBackgroundColor: AppColors.primary,
            backgroundColor: AppColors.lightGray,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.title,
              ),
              iconTheme: IconThemeData(
                color: AppColors.primary,
              ),
            ),
            primaryTextTheme: TextTheme(
              headline6: w700BitterFont,
            ),
            textTheme: TextTheme(
              headline6: w700BitterFont.apply(color: AppColors.title),
              bodyText2: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.title,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColors.stroke,
              elevation: 4,
              selectedLabelStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.title,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.title,
              ),
              unselectedItemColor: AppColors.gray,
            ),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
