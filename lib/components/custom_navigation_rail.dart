import 'package:flutter/material.dart';

class CustomNavigationRail extends StatelessWidget {
  final List<CustomNavigationRailDestination> destinations;
  final Widget leading;
  final Widget? trailing;
  const CustomNavigationRail(
      {required this.leading,
      required this.trailing,
      required this.destinations,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading,
            const SizedBox(height: 20),
            for (int index = 0; index < destinations.length; index++)
              ListTile(
                minLeadingWidth: 25,
                leading: Icon(
                  destinations[index].icon,
                  color:
                      destinations[index].selected ? Colors.white : Colors.grey,
                ),
                title: Text(
                  destinations[index].label,
                  style: TextStyle(
                      color: destinations[index].selected
                          ? Colors.white
                          : Colors.grey),
                ),
                onTap: () {
                  for (CustomNavigationRailDestination e in destinations) {
                    e.selected = false;
                  }
                  destinations[index].selected = true;
                  destinations[index].onTap();
                },
              ),
            const Spacer(),
            trailing ?? const SizedBox(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomNavigationRailDestination {
  final IconData icon;
  final String label;
  final Function onTap;
  bool selected;

  CustomNavigationRailDestination(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.selected = false});

  setSelected(bool value) {
    selected = true;
  }
}
