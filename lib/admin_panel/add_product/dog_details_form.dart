


import 'package:flutter/material.dart';

class DogDetailsForm extends StatelessWidget {

  final TextEditingController breedController;
  final TextEditingController colorsController;
  final TextEditingController trainedController;
  final TextEditingController ageController;
  final TextEditingController priceController;

  const DogDetailsForm({Key? key,
    required this.breedController,
    required this.colorsController,
    required this.trainedController,
    required this.ageController,
    required this.priceController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: breedController,
            decoration: InputDecoration(
              labelText: 'breed',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please breed';
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
            controller: trainedController,
            decoration: InputDecoration(
              labelText: 'YES if trained NO otherwise',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide info if trained or not';
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
    ;
  }
}
