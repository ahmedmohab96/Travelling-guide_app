import 'package:flutter/material.dart';
import './app_data.dart';
import './models/trip.dart';
import 'package:traveling_app/screens/categories_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:traveling_app/screens/category_trips_screen.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/trip_detail_screen.dart';
import './screens/category_trips_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  List<Trip> _favoriteTrips = [];

  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips = Trips_data.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(
        () {
          _favoriteTrips.add(
            Trips_data.firstWhere((trip) => trip.id == tripId),
          );
        },
      );
    }
  }

  bool _isFavorite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
      ],
      title: 'Traveling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        fontFamily: 'ElMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline5: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'ElMessiri',
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteTrips),
        CategoryTripsScreen.screenRoute: (ctx) =>
            CategoryTripsScreen(_availableTrips),
        TripDetailScreen.screenRoute: (ctx) =>
            TripDetailScreen(_manageFavorite, _isFavorite),
        FilterScreen.screenRoute: (ctx) =>
            FilterScreen(_filters, _changeFilters),
      },
    );
  }
}
