import 'dart:io';

import 'package:flutter/services.dart';

void update_certs() async {
  var data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
}
