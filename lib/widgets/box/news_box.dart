import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/service/service.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loa_market/widgets/basic/progress.dart';

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
      final List<dynamic> newsData = await fetchNews();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      title: '최근 업데이트',
                      fontSize: 'large',
                    ),
                  ),
                  const Gap(20),
                  if (isLoading) Progress(),
                  if (!isLoading && newsList != null)
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: newsList!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                launchUrl(Uri.parse(newsList![index]['Link']));
                              },
                              child: CustomText(
                                title: newsList![index]['Title'],
                                fontSize: 'medium',
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ],
              ))),
    );
  }
}
