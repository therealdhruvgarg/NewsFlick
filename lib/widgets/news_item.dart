import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:news_app/models/article.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

class NewsItem extends StatelessWidget {
  final Article article;
  const NewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return HoverButton(
      onPressed: (() async {
        if (!await launch(article.uri)) {
          log('Could not launch ${article.uri}');
        }
      }),
      cursor: SystemMouseCursors.click,
      builder: (context, states) {
        return material.Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  child: Container(
                      width: double.infinity,
                      height: 180,
                      color: material.Color.fromARGB(255, 61, 61, 61),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        imageErrorBuilder: (ctx, error, StackTrace) {
                          return Icon(
                            material.Icons.image,
                            color: material.Colors.grey.shade300,
                          );
                        },
                        fit: BoxFit.cover,
                        image: article.urlToImage ??
                            'https://via.placeholder.com/180',
                      )),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Text(
                        article.title,
                        style: typography.bodyLarge?.apply(fontSizeFactor: 0.8),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.captionText(),
                          style: typography.caption?.apply(fontSizeFactor: 1),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DropDownButton(
                        title: const Icon(FluentIcons.share),
                        items: [
                          MenuFlyoutItem(
                            text: const Text('Open in Browser'),
                            leading: const Icon(FluentIcons.edge_logo),
                            onPressed: () async {
                              if (!await launch(article.uri)) {
                                log('Could not launch ${article.uri}');
                              }
                            },
                          ),
                          MenuFlyoutItem(
                            text: const Text('Send'),
                            leading: const Icon(FluentIcons.send),
                            onPressed: () {
                              Share.share('Check out this article ${article.uri}');
                            },
                          ),
                          MenuFlyoutItem(
                            text: const Text('Copy URL'),
                            leading: const Icon(FluentIcons.copy),
                            onPressed: () {
                              FlutterClipboard.copy(article.uri).then((value) {
                                showCopiedSnackbar(context, article.uri);
                              }).catchError((error) {
                                log('Failed to copy URL: $error');
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  void showCopiedSnackbar(BuildContext context, String copiedText) {
    material.ScaffoldMessenger.of(context).showSnackBar(
      material.SnackBar(
        content: RichText(
          text: TextSpan(
            text: 'Copied ',
            style: const TextStyle(color: material.Colors.white),
            children: [
              TextSpan(
                text: copiedText,
                style: const TextStyle(
                  color: material.Colors.orange,
                  fontWeight: material.FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
