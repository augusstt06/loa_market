import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/service/service.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
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
                    child: Text(
                      '최근 업데이트',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const Gap(20),
                  if (isLoading) CircularProgressIndicator(),
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
                              child: Text(
                                newsList![index]['Title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
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
