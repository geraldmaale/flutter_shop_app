import 'package:flutter/material.dart';

class Nature extends StatelessWidget {
  const Nature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Talk about nature'),
      ),
      body: ListView(
        children: [
          Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection(context),
          buttonSection(context),
          textSection(context),
        ],
      ),
    );
  }
}

Widget titleSection(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
    ),
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text('Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.error,
        ),
        Text('41',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            )),
      ],
    ),
  );
}

Widget buttonSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(
          context, Theme.of(context).colorScheme.primary, Icons.call, 'CALL'),
      _buildButtonColumn(context, Theme.of(context).colorScheme.primary,
          Icons.near_me, 'ROUTE'),
      _buildButtonColumn(
          context, Theme.of(context).colorScheme.primary, Icons.share, 'SHARE'),
    ],
  );
}

Widget textSection(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
    ),
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    ),
  );
}

Column _buildButtonColumn(
    BuildContext context, Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
