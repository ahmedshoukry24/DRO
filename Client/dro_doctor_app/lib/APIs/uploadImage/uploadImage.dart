import 'dart:io';
import 'package:async/async.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:path/path.dart';
import 'package:image/image.dart' as Img;


class UploadImage{

  String imageName;


  Future<File> getImage(String type)async{
    var imageFile;
    if(type == 'G'){
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    }else if (type == 'C'){
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    if(imageFile != null) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      var rng = new Random();
      imageName = "${rng.nextInt(1000000000)}_Image_${rng.nextInt(1000000000)}.jpg";
      Img.Image _image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImage = Img.copyResize(_image, width: 500);
      var compressedImage = new File("$path/$imageName")
        ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));
      return compressedImage;
    }else return null;
  }

  Future<bool> upload (File imageFile,String type)async{
    var steam = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length =await imageFile.length();
    var uri;
    if(type == 'D'){
      uri = Uri.parse("${imageLoc}uploadDoctorImage.php");
    }else if(type == 'P'){
      uri = Uri.parse("${imageLoc}uploadPrescription.php");
    }else if(type == 'OF'){
      uri = Uri.parse("${imageLoc}uploadPhotosOf.php");
    }
    else if(type == 'offer'){
      uri = Uri.parse("${imageLoc}uploadOffersImage.php");
    }
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