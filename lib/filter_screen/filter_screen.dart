

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/filter_provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final birdsFilter=Provider.of<FilterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: ListView.builder(
        itemCount: 1,
          itemBuilder: (BuildContext context,item){
        return SwitchListTile(
          title:const Text("Birds"),
            subtitle: const Text("Press the button to filter birds"),
            value: birdsFilter.filterData["birds"],
            onChanged: (boolVal){
             birdsFilter.filterBirds(boolVal);
        });
      }),
    );
  }
}
