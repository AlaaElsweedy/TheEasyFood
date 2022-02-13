import 'package:flutter/cupertino.dart';

String? uId = '';

//here and in the manifest
String googleApiKey = '';

const suggestionsBaseUrl =
    'https://maps.googleapis.com/maps/api/place/autocomplete/json';

const placeLocationBaseUrl =
    'https://maps.googleapis.com/maps/api/place/details/json';

const directionsBaseUrl =
    'https://maps.googleapis.com/maps/api/directions/json';

const SizedBox sizedBox12 = SizedBox(height: 12);

const SizedBox sizedBox28 = SizedBox(height: 28);

const SizedBox sizedBox20 = SizedBox(height: 20);

const SizedBox sizedBox10 = SizedBox(height: 10);

const SizedBox sizedBox15 = SizedBox(height: 15);

const EdgeInsets paddingAll = EdgeInsets.all(20);

const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 20);
