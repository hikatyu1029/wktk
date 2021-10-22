import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class TimelineTile extends StatelessWidget {
  const TimelineTile(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.text,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(4, 12, 4, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LikeButton(
                        likeCount: 19,
                      ),
                      LikeButton(
                        likeBuilder: (bool isTapped) {
                          return Icon(Icons.message);
                        },
                      ),
                      Flex(direction: Axis.horizontal)
                    ],
                  ))
            ],
          ))
        ],
      ),

      // child: ListTile(
      //   leading: Icon(
      //     Icons.person,
      //     size: 50,
      //   ),
      //   subtitle: Text('A sufficiently long subtitle warrants three lines.'),
      //   isThreeLine: true,
      // ),
    );
  }
}
