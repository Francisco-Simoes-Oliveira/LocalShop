import 'package:flutter/material.dart';

class Userroleselectioncard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color cor;
  final String routeName;

  const Userroleselectioncard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
    this.cor = const Color(0xFF2563EB),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: cor, size: 40),
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
