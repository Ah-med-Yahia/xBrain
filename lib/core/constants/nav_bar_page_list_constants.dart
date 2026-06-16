import 'package:explaino/features/tabs/home/presentation/screens/home_screen.dart';
import 'package:explaino/features/tabs/profile/main_profile/presentation/screens/main_profile_screen.dart';
import 'package:flutter/material.dart';

final List<Widget> navBarPages = [
  const HomeScreen(),
  Container(color: Colors.green, height: 2000),
  Container(color: Colors.blue, height: 2000),
  Container(color: Colors.yellow, height: 2000),
  const ProfileScreen(),
];
