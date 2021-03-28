import 'file:///C:/Users/faris/IdeaProjects/buy_food/lib/screens/category_meals_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dummy.data.dart';
import 'dart:io';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.title, this.color, this.id);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed('/categories', arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.7), color],
            ),
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
