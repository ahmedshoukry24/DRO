import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:path/path.dart';
import 'package:image/image.dart' as Img;
import '../URL/mainURL.dart';


class UploadImage{

  var imageName,randomNumber;


  Future<File> getImage(String patientID)async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      var rng = new Random();
      randomNumber = rng.nextInt(1000000000);
      imageName = "${patientID}Image_$randomNumber.jpg";
      Img.Image _image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImage = Img.copyResize(_image, width: 500);
      var compressedImage = new File("$path/$imageName")
        ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));
      return compressedImage;
    }else return null;
  }

  Future upload (File imageFile)async{
    var steam = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length =await imageFile.length();
    var uri =Uri.parse("${imageLoc}uploadPatientImage.php");
    var request = http.MultipartRequest("POST",uri);
    var multiPartFile = http.MultipartFile("image",steam,length,filename: basename(imageFile.path));
    request.files.add(multiPartFile);
    var response =await request.send();
    if(response.statusCode==200){
      return true;
    }
    else return false;
  }

}