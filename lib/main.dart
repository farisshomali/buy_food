import 'file:///C:/Users/faris/IdeaProjects/buy_food/lib/screens/categories_screen.dart';
import 'file:///C:/Users/faris/IdeaProjects/buy_food/lib/screens/category_meals_screen.dart';
import 'package:buy_food/dummy.data.dart';
import 'package:buy_food/models/meal.dart';
import 'package:buy_food/screens/filters_screen.dart';
import 'package:buy_food/screens/meal_detail_screen.dart';
import 'package:buy_food/screens/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        /// Filtering Logic
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DeliMeals',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              accentColor: Colors.amber,
              canvasColor: Color.fromRGBO(255, 255, 250, 1),
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                  body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1))),
              fontFamily: 'OpenSans',
            ),
            // home: CategoriesScreen(),
            routes: {
              '/': (context) => TabsScreen(_favoriteMeals),
              '/categories': (context) => CategoryMealsScreen(_availableMeals),
              MealDetailScreen.routeName: (context) =>
                  MealDetailScreen(_toggleFavorite, _isMealFavorite),
              FiltersScreen.routeName: (context) =>
                  FiltersScreen(_filters, _setFilters),
            },
          )
        : CupertinoApp(
            theme: CupertinoThemeData(primaryColor: Colors.deepOrange),
            debugShowCheckedModeBanner: false,
            home: CategoriesScreen(),
            title: 'DeliMeals',
          );
  }
}
