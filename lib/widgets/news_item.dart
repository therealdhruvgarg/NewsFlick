import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return Card(
      padding: const EdgeInsets.only(bottom:8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6)
          ),
          child: Container(
            width: double.infinity,
            height: 180,
            color :  material.Colors.green.shade700,
            child:        FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            imageErrorBuilder: (ctx, error, StackTrace) {
              return Icon(
                material.Icons.image,
                color: material.Colors.grey.shade300,
              );
            },
            fit: BoxFit.cover,
            image:
                "https://i.ytimg.com/vi/shJIhLf5838/hqdefault_3265100.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB4ORxstTsv4_098zMG_la5YqDXUg")
          ),
          ),
        Expanded(child: Padding(padding: const EdgeInsets.only(top : 8 , left : 8 ,right: 8),
        child:Text('Elon Musk' ,
        style:typography.bodyLarge?.apply(fontSizeFactor: 0.8),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,)), 
        ),
        Padding(padding: const EdgeInsets.only(top:8, right: 8,left: 8 ),
        child: Row(
          children: [
            Expanded(
              child: Text('Beebom - 2 Hours ago',
                style: typography.caption?.apply(fontSizeFactor: 1),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
                ),
                DropDownButton(items: [
                  
                ])
        ],),
        )
      ],
    ));
  }
}
