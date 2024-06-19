import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static String route() => "/map";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          // When the user taps the button, show a snackbar.
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Pop up message',
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            );
            // context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Map Button',
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
