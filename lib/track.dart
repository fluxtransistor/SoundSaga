import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Track {
  String responseBody;
  Map<String, dynamic> map;
  String trackName;
  String id;
  Image img;
  Track(String idInput) {
    id = idInput;
    trackName = "Loading...";
    img = Image(image: AssetImage("assets/dsotm.jpg"));
    load();
  }
  void load() async {
    responseBody = await Metadata.fetchTrack(id);
    Map<String, dynamic> map = json.decode(responseBody);
    trackName = map["title"];
    img = Image(image: NetworkImage(map[""]))
  }
}

class Metadata {
  static String url = 'https://api.discogs.com/releases/';
  
  static Future<String> fetchTrack(String id) async {
    final response = await http.get(url + id);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}