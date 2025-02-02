import 'package:flutter/material.dart';
import 'package:loa_market/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.toggleTheme,
  });

  final void Function() toggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOA Market'),
      ),
      body: Column(
        children: [
          SearchWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.toggleTheme,
        child: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.sunny
                : Icons.nightlight,
            color: Colors.white),
      ),
    );
  }
}
