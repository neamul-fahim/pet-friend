

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/filter_provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter=Provider.of<FilterProvider>(context);
    List<String> filterName=["bird","dog","cat"];


    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: ListView.builder(
        itemCount: filterName.length,
          itemBuilder: (BuildContext context,item){
        return SwitchList(filterName: filterName[item],filter: filter);
      }),
    );
  }
}


class SwitchList extends StatelessWidget {
  final filterName;
  final filter;
  const SwitchList({Key? key,required this.filterName, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile(
        title:Text(filterName),
        subtitle:Text("Press the button to filter birds"),
        value: filterName=="bird"?filter.filterData["birds"]
            :filterName=="dog"?filter.filterData["dogs"]:filter.filterData["cats"],

        onChanged: (boolVal){
         if(filterName=="bird") filter.filterBirds(boolVal);
         if(filterName=="dog") filter.filterDogs(boolVal);
         if(filterName=="cat") filter.filterCats(boolVal);
        });

  }
}
