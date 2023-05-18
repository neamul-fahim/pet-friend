
import 'package:flutter/material.dart';


class BirDetailsForm extends StatelessWidget {


  final TextEditingController nameController;
  final TextEditingController colorsController;
  final TextEditingController talkController;
  final TextEditingController flyController;
  final TextEditingController ageController;
  final TextEditingController priceController;

   const BirDetailsForm({Key? key,
    required this.nameController,
     required this.colorsController,
     required this.talkController,
     required this.flyController,
     required this.ageController,
     required this.priceController,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: TextFormField(
            controller: colorsController,
            decoration: InputDecoration(
              labelText: 'Enter colors using comma',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter colors';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: talkController,
            decoration: InputDecoration(
              labelText: 'YES if can talk or NO otherwise',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide info if can talk or not';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: flyController,
            decoration: InputDecoration(
              labelText: 'YES if can fly or NO otherwise',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide info if can fly';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              labelText: 'Age Ex: 1 year 6 months',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide Age';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide price';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
