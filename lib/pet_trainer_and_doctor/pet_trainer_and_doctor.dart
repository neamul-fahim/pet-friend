import 'package:flutter/material.dart';


class PetTrainerAndDoctor extends StatefulWidget {
  @override
  _PetTrainerAndDoctorState createState() => _PetTrainerAndDoctorState();
}

class _PetTrainerAndDoctorState extends State<PetTrainerAndDoctor>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Information'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Pet Trainers',
              icon: Icon(Icons.pets),
            ),
            Tab(
              text: 'Pet Doctors',
              icon: Icon(Icons.healing),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PetTrainersScreen(),
          PetDoctorsScreen(),
        ],
      ),
    );
  }
}

class PetTrainersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with your actual data count for trainers
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PetTrainerCard(),
        );
      },
    );
  }
}

class PetDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Replace with your actual data count for doctors
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PetDoctorCard(),
        );
      },
    );
  }
}

class PetTrainerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name of the Pet Trainer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Phone Number: 123-456-7890'),
            Text('Email: trainer@example.com'),
            Text('Address: 456, Trainer Street'),
          ],
        ),
      ),
    );
  }
}

class PetDoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name of the Pet Doctor',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Phone Number: 987-654-3210'),
            Text('Email: doctor@example.com'),
            Text('Address: 123, Doctor Avenue'),
          ],
        ),
      ),
    );
  }
}
