import 'package:flutter/material.dart';
import 'package:loa_market/widgets/basic/global_appbar.dart';
import 'package:loa_market/widgets/box/announce_box.dart';
import 'package:loa_market/widgets/box/crystal_box.dart';
import 'package:loa_market/widgets/box/news_box.dart';
import 'package:loa_market/widgets/basic/search.dart';

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
      appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Search(toggleTheme: widget.toggleTheme),
          ),
          const AnnounceBox(),
          NewsBox(),
          CrystalBox(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: widget.toggleTheme,
      //   backgroundColor: Colors.amber,
      //   child: Icon(
      //       Theme.of(context).brightness == Brightness.dark
      //           ? Icons.sunny
      //           : Icons.nightlight,
      //       color: Colors.white),
      // ),
    );
  }
}
