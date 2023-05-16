import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';

class MyWebView extends StatefulWidget {
  final String url;

  MyWebView({required this.url});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late InAppWebViewController _controller;
  Position? _currentPosition;

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permission required.'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  Future<void> _enableLocationInWebView() async {
    await _checkPermission();
    if (_currentPosition != null) {
      final latitude = _currentPosition!.latitude.toString();
      final longitude = _currentPosition!.longitude.toString();
      final script =
          'navigator.geolocation.getCurrentPosition = function(success, error) { success({ coords: { latitude: $latitude, longitude: $longitude } }); }';
      await _controller.evaluateJavascript(source: script);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        onWebViewCreated: (controller) {
          _controller = controller;
          _enableLocationInWebView();
        },
      ),
    );
  }
}
