import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/get.dart';
import 'package:loa_market/service/service.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/bottom_sheet/news_sheet.dart';

class NewsBox extends StatefulWidget {
  const NewsBox({super.key});

  @override
  State<NewsBox> createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> {
  String? title;
  String? date;
  bool isLoading = true;
  List<dynamic>? newsList;

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    try {
      final TGetNewsResponse newsData = await fetchNews();
      setState(() {
        newsList = newsData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showNewsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return NewsSheet(
            newsList: newsList,
            isLoading: isLoading,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: _showNewsSheet,
          borderRadius: BorderRadius.circular(10),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomText(
                          title: '최근 로아 소식',
                          fontSize: 'large',
                          isBold: true,
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
