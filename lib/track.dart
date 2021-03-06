import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

final String authHeader =
    "Discogs key=MFmrWQujZMHvnzKzFclH, secret=bKQuEuBxsMuhtTnSBuxwndDavzzKVINX";
final String userAgent =
    "SoundSaga/0.1 +http://github.com/fluxtransistor/SoundSaga";

class DemoTrack1 extends Track {
  @override
  DemoTrack1() : super('');
  String name = "Eclipse";
  String artist = "Pink Floyd";
  Image img = Image(image: AssetImage("assets/dsotm.jpg"));
}

class DemoTrack2 extends Track {
  @override
  DemoTrack2() : super('');
  String name = "I Wish";
  String artist = "Stevie Wonder";
  Image img = Image(image: AssetImage("assets/life.jpg"));
}

class Track {
  String responseBody;
  Map<String, dynamic> map;
  String name;
  String id;
  Image img;
  String artist;

  Track(String idInput) {
    id = idInput;
    if (img == null) {
      name = "Loading...";
      img = Image(image: AssetImage("assets/dsotm.jpg"));
    }
    if (id != '') {
      load();
    }
  }

  void load() async {
    responseBody = await DiscogsMetadata.fetchTrack(id);
    Map<String, dynamic> map = json.decode(responseBody);
    name = map["title"];
    img = Image(image: NetworkImage(map["images"][0]["uri"]));
  }
}

class DiscogsMetadata {
  static String url = 'https://api.discogs.com/releases/';

  static Future<String> fetchTrack(String id) async {
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    headers['Authorization'] = authHeader;
    headers['User-agent'] = userAgent;
    final response = await http.get(url + id, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
