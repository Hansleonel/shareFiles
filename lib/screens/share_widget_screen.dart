import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareWidgetScreen extends StatefulWidget {
  @override
  _ShareWidgetScreenState createState() => _ShareWidgetScreenState();
}

class _ShareWidgetScreenState extends State<ShareWidgetScreen> {
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Share Baptist Widget'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Screenshot(
            controller: _screenshotController,
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/image01.jpg'),
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Widget Personalizado Baptist',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
          ),
          ElevatedButton(
              onPressed: () {
                _takeScreenshot();
              },
              child: Text('Share Widget'))
        ])));
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();

    final tempDir = await getTemporaryDirectory();
    final file =
        await new File('${tempDir.path}/EarlyDetectionWidget.jpg').create();
    file.writeAsBytesSync(imageFile!);

    final path = file.path;
    String text = 'Link Shared';

    if (Platform.isAndroid) {
      text =
          'https://play.google.com/store/apps/details?id=com.osellus.android.pineapp&hl=es';
    } else if (Platform.isIOS) {
      text = 'https://apps.apple.com/us/app/pineapp/id393333579';
    }

    Share.shareFiles([path], text: text);
  }
}
