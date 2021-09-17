import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baptist Share'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Container(
            alignment: Alignment.center,
            child: (Image(
                fit: BoxFit.cover,
                width: 300,
                image: AssetImage('assets/image01.jpg'))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () {
          print('share');

          shareImage();
        },
      ),
    );
  }

  void shareImage() async {
    final ByteData bytes = await rootBundle.load('assets/image01.jpg');
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/EarlyDetection.jpg').create();
    file.writeAsBytesSync(list);
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
