import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/colors.dart';
import 'package:flutter_shop_app/constants/user_roles.dart';
import 'package:flutter_shop_app/pages/auth/login_screen.dart';
import 'package:flutter_shop_app/pages/auth/show_claims.dart';
import 'package:flutter_shop_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> claims = {};

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false)
        .getUserClaims()
        .then((value) {
      claims = value;
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      claims = Provider.of<UserProvider>(context).claims;
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Talk about nature'),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Clear all shared preferences
              Provider.of<UserProvider>(context, listen: false)
                  .clearAndLogout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection(context, claims),
          buttonSection(context, claims),
          textSection(context),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 32,
              bottom: 8,
            ),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ShowClaimsScreen(claims: claims);
                      }),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.favorite),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    "Show ${claims.length} Claims ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget titleSection(BuildContext context, Map<String, dynamic> userClaims) {
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
                  "Hi ${userClaims["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(userClaims.isNotEmpty ? userClaims["email"] : "",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.star,
          color: AppColors.favorite,
        ),
        Text(userClaims.length.toString(),
            style: TextStyle(
              color: AppColors.favorite,
            )),
      ],
    ),
  );
}

Widget buttonSection(BuildContext context, Map<String, dynamic> claims) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      if (claims[ClaimTypes.role] == ClaimTypes.systemAdmin)
        _buildButtonColumn(
            context, Theme.of(context).colorScheme.primary, Icons.edit, 'EDIT'),
      if (claims[ClaimTypes.role] == ClaimTypes.systemAdmin)
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
