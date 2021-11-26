import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem {
  String title;
  String subtitle;
  String imagePath;
  Function onClick;

  CardItem(this.title, this.subtitle, this.imagePath, this.onClick);
}

class CardButton extends StatelessWidget {
  CardItem item;

  CardButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        child: InkWell(
          splashColor: Colors.deepPurple.withAlpha(30),
          child: Container(
              width: 170,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.deepPurple[200],
                      child: const Icon(
                        Icons.headset,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.deepPurple),
                        )
                      ],
                    ),
                  )
                ],
              )),
          onTap: () {
            print('Card tapped.');
          },
        ),
      ),
    );
  }
}
