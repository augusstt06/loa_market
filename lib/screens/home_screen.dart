import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/post.dart';

import 'package:loa_market/widgets/bottom_sheet/search_result_sheet.dart';
import 'package:loa_market/widgets/basic/appbar/global_appbar.dart';
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
  List<Item> _searchResult = [];

  void _showSearchResultDialog(List<Item> items) {
    setState(() {
      _searchResult = items;
    });
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SearchResultSheet(
            items: _searchResult,
            toggleTheme: widget.toggleTheme,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Search(
                    toggleTheme: widget.toggleTheme,
                    onSearch: _showSearchResultDialog),
              ),
              Center(child: const AnnounceBox()),
              Center(child: NewsBox()),
              Center(child: CrystalBox()),
            ],
          ),
        ),
      ),
    );
  }
}
