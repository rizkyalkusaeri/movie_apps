import 'package:flutter/material.dart';

String formatAmount(String price) {
  String priceInText = "";
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

String formatTime(String value) {
  var data = value;
  if (data == "") {
    return data;
  } else {
    var split = value.split(".");

    var pisahTanggalJam = split[0].split(' ');

    var pisahTahunBulanHari = pisahTanggalJam[0].split('-');
    var tahun = pisahTahunBulanHari[0];
    var bulan = pisahTahunBulanHari[1];
    var hari = pisahTahunBulanHari[2];

    var pisahMenitDetik = pisahTanggalJam[1].split(':');
    data = '$hari/$bulan/$tahun ${pisahMenitDetik[0]}:${pisahMenitDetik[1]}';
    return data;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
