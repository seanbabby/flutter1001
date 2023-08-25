import 'package:flutter/material.dart';
import 'package:hello_mdfk/state/myappstate.dart';
import 'package:provider/provider.dart';

// ListView
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('there\'s no fav data'),
      );
    }

    return ListView(
      children: [
        for (var pair in appState.favorites)
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
