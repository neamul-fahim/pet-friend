import 'package:flutter/material.dart';
import 'package:pet_friend/pet_disease_remedy_article/pet_disease_remedy_article.dart';


   var dogArticle=PetDiseaseRemedy().dogDiseaseRemedyArticle;
   var catArticle=PetDiseaseRemedy().catDiseaseRemedyArticle;
   var birdArticle=PetDiseaseRemedy().birdDiseaseRemedyArticle;

class PetInfoScreen extends StatelessWidget {
  final List<String> _tabs = ['Dog', 'Cat', 'Bird'];

  final Map<String, String> articles = {
    'Dog': dogArticle,
    'Cat': catArticle,
    'Bird': birdArticle,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pet Information'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.map((petType) => PetDiseasesScreen(petType: petType, article: articles[petType])).toList(),
        ),
      ),
    );
  }
}

class PetDiseasesScreen extends StatelessWidget {
  final String petType;
  final String? article;

  PetDiseasesScreen({required this.petType, this.article});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1, // Replace with the actual number of articles about pet diseases
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: PetDiseaseArticleCard(petType: petType, article: article ?? ''),
        );
      },
    );
  }
}

class PetDiseaseArticleCard extends StatelessWidget {
  final String petType;
  final String article;

  PetDiseaseArticleCard({required this.petType, required this.article});

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
              '$petType Disease And Remedy Article',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              article,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample articles for demonstration purposes
