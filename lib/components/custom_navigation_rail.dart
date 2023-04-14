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
                leading: destinations[index].icon,
                title: destinations[index].label,
                onTap: () {
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
  final Icon icon;
  final Text label;
  final Function onTap;

  const CustomNavigationRailDestination(
      {required this.icon, required this.label, required this.onTap});
}
