import 'dart:io';

String fixture({required String fileName}) =>
    File('test/fixtures/$fileName').readAsStringSync();
