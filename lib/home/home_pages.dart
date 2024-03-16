
import 'package:homework_api/home/time_table.dart';
import 'package:flutter/material.dart';

var kBottomBarBackgroundColor = Colors.purple[800];
var kBottomBarForegroundActiveColor = Colors.white;
var kBottomBarForegroundInactiveColor = Colors.white60;
var kSplashColor = Colors.purple[600];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return const TimeTable();
        case 1:
          //return const Attendance();
        case 2:
          //return const AppNotification();
        default:
          return const TimeTable();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries of the world'),
      ),
      
      
      body: buildPageBody(),
    );
  }
}

class AppBottomMenuItem extends StatelessWidget {
  AppBottomMenuItem({
    super.key,
    required this.iconData,
    required this.text,
    required this.isSelected,
    required this.onClick,
  });

  final IconData iconData;
  final String text;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected
        ? kBottomBarForegroundActiveColor
        : kBottomBarForegroundInactiveColor;

    return ClipOval(
      child: Material(
        color: Colors.transparent, // button color
        child: InkWell(
          // splashColor: kSplashColor,
          onTap: onClick, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: color,
                  // fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}