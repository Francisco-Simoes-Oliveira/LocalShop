import 'package:flutter/material.dart';

class Userroleselectioncard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String routeName;

  const Userroleselectioncard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF2563EB), size: 40),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        onTap: () => Navigator.of(context).pushNamed(routeName),
      ),
    );
  }
}
