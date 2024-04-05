import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';

class FileUploader {

  // fileType에는 영상일 경우 video, 이미지일 경우 image가 들어감
  Future<Map<String, dynamic>> uploadFile(String fileName, String fileType, Uint8List fileBytes, {void Function()? onProgress, void Function()? onError}) async {

    String encodeFileBytes = base64Encode(fileBytes);
    String fileMd5Hash = md5.convert(fileBytes).toString();
    fileName = "${fileName.substring(0, fileName.lastIndexOf("."))}_$fileMd5Hash${fileName.substring(fileName.lastIndexOf("."))}";
    int fileSize = encodeFileBytes.length;

    int chunkSize = 1024 * 1024 * 10;
    int totalChunks = (fileSize / chunkSize).ceil();
    int currentChunk = 0;
    Response response = Response("", 206);

    while(response.statusCode != 200) {
      String chunkBytes = encodeFileBytes.substring((currentChunk * chunkSize), min((currentChunk * chunkSize) + chunkSize, fileSize));
      response = await _chunkUpload(fileName, fileType, chunkBytes, currentChunk, totalChunks);
      if(response.statusCode != 206 && response.statusCode != 200) {
        onError?.call();
        break;
      }
      onProgress?.call();
      currentChunk++;
    } 

    // upload loop end
    if(response.statusCode == 200) {
      return { "result": true, "url": jsonDecode(utf8.decode(response.bodyBytes))["url"] };
    } else {
      return { "result": false, "url": ""};
    }

  }


  Future<Response> _chunkUpload(String fileName, String fileType, String chunkBytes, int chunkCount, int totalChunks) async {
    Response response;
    try {
      response = await post(
        Uri.parse("http://localhost:8021/content/upload"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fileName": fileName,
          "fileType" : fileType,
          "fileBytes": chunkBytes,
          "chunkCount": chunkCount,
          "totalChunks" : totalChunks
        })
      );
      return response;
    } catch (error) {
      print(error);
      return Response("", 400);
    }
  }




}