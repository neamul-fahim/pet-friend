import 'package:flutter/material.dart';

class BottomNavigationSearch extends StatefulWidget {
  const BottomNavigationSearch({Key? key}) : super(key: key);

  @override
  State<BottomNavigationSearch> createState() => _BottomNavigationSearchState();
}

class _BottomNavigationSearchState extends State<BottomNavigationSearch> {
  @override

  Widget build(BuildContext context) {
    return Container(
      child: Text('This is search page'),
    );
  }
}
