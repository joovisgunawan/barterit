import 'package:barterit/models/user.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  final User user;
  const NotificationScreen({super.key, required this.user});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification')),
    );
  }
}
