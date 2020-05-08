import 'package:flutter/material.dart';

class AfficheModel {
  static List<Map<String, dynamic>> _moviesDB = [
    {
      'name': 'Gossip Girl',
      'image': 'images/GG56.jpg',
      'description': 'some text',
      'rating': 9.5,
      'year': 2008,
      'duration': '45 min',
    },
    {
      'name': 'White Gold',
      'image': 'images/white_gold.jpg',
      'description': 'some text',
      'rating': 8.7,
      'year': 2018,
      'duration': '25 min',
    },
    {
      'name': "The Carrie's Diaries",
      'image': 'images/carry-diaries.png',
      'description': 'some text',
      'rating': 8.0,
      'year': 2012,
      'duration': '50 min',
    },
    {
      'name': 'Pretty Liars',
      'image': 'images/pretty-liars.jpg',
      'description': 'some text',
      'rating': 7.8,
      'year': 2015,
      'duration': '1h 5 min',
    },
    {
      'name': 'One Tree Hill',
      'image': 'images/one-tree-hill.jpg',
      'description': 'some text',
      'rating': 9.0,
      'year': 2010,
      'duration': '40 min',
    },
    {
      'name': '13 Reasons Why',
      'image': 'images/13RW-Poster.jpg',
      'description': 'some text',
      'rating': 9.4,
      'year': 2019,
      'duration': '53 min',
    },
    {
      'name': 'Riverdale',
      'image': 'images/riverdale.jpg',
      'description': 'some text',
      'rating': 8.4,
      'year': 2017,
      'duration': '48 min',
    },
    {
      'name': 'Dynasty',
      'image': 'images/dynasty.jpg',
      'description': 'some text',
      'rating': 7.9,
      'year': 2014,
      'duration': '50 min',
    },
    {
      'name': 'Game of Thrones',
      'image': 'images/game_of_thrones.jpg',
      'description': 'some text',
      'rating': 9.3,
      'year': 2018,
      'duration': '1h 20 min',
    },
    {
      'name': 'Sherlock',
      'image': 'images/sherlock.jpg',
      'description': "Sherlock is a British crime drama television series based on Sir Arthur Conan Doyle's Sherlock Holmes detective stories. Created by Steven Moffat and Mark Gatiss, it stars Benedict Cumberbatch as Sherlock Holmes and Martin Freeman as Doctor John Watson.",
      'rating': 9.7,
      'year': 2013,
      'duration': '49 min',
    },
    {
      'name': 'Harrow',
      'image': 'images/harrow.jpg',
      'description': "This is Harrow",       
      'rating': 9.8,
      'year': 2016,
      'duration': '50 min',
    },
    {
      'name': 'How to get away with murder',
      'image': 'images/murder.jpg',
      'description': 'This is HTGAWM',
      'rating': 8.7,
      'year': 2014,
      'duration': '55 min',
    },
    {
      'name': 'Mentalist',
      'image': 'images/mentalist.jpg',
      'description': 'This is Mentalist',
      'rating': 8.9,
      'year': 2007,
      'duration': '47 min',
    },
    {
      'name': 'Forever',
      'image': 'images/forever.jpg',
      'description': 'This is Forever',
      'rating': 8.5,
      'year': 2012,
      'duration': '50 min',
    },
    {
      'name': 'Elementary',
      'image': 'images/elementary.jpg',
      'description': 'This is Elementary',
      'rating': 8.7,
      'year': 2011,
      'duration': '49 min',
    },
  ];

  //Get Movie by id
  Movie getById(int id) => Movie(
      id,
      _moviesDB[id]['name'],
      _moviesDB[id]['image'],
      _moviesDB[id]['description'],
      _moviesDB[id]['rating'],
      _moviesDB[id]['year'],
      _moviesDB[id]['duration']);

  // Movie getByPosition(int position) {
  //   return getById(position);
  // }
}

@immutable
class Movie {
  final int id;
  final String name;
  final double rating;
  final String image;
  final String description;
  final int year;
  final String duration;

  Movie(this.id, this.name, this.image, this.description, this.rating,
      this.year, this.duration);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Movie && other.id == id;
}
