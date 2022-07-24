import 'dart:io';

import 'package:dro_doctor_app/APIs/Common/PhotosOfAPI.dart';
import 'package:dro_doctor_app/APIs/mainURL/mainURL.dart';
import 'package:dro_doctor_app/APIs/uploadImage/uploadImage.dart';
import 'package:dro_doctor_app/UI/Custom/CustomDialog.dart';
import 'package:dro_doctor_app/UI/Custom/MyCustomImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotosOf extends StatefulWidget {
  final String clinicID, centerID;

  const PhotosOf(this.clinicID, this.centerID);

  @override
  _PhotosOfState createState() => _PhotosOfState();
}

class _PhotosOfState extends State<PhotosOf> {


  bool show = false;

  List<dynamic> imagesListToShow ;
  List<String> newImageNames;
  List<File> newImageFiles;

  PhotosOfAPI _photosOfAPI;
  UploadImage _uploadImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagesListToShow = List<dynamic>();
    newImageNames =List<String>();
    newImageFiles = List<File>();
    _photosOfAPI = PhotosOfAPI();

  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: _photosOfAPI.getPhotosOf(centerID: widget.centerID,clinicID: widget.clinicID),
            builder: (context,ss){
              if(ss.hasError){
                print('Error');
              }
              if(ss.hasData){
               imagesListToShow = ss.data;

               newImageFiles.forEach((element) {
                 if(!imagesListToShow.contains(element)){
                   imagesListToShow.add(element);
                 }
               });
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemCount: imagesListToShow.length+1 <= 5 ? imagesListToShow.length+1 : 6,
                    itemBuilder: (context, position) {
                      return position == imagesListToShow.length
                          ? GestureDetector(
                        onTap: ()=>_getImage(),
                        child: Container(
                          color: Colors.grey[300],
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Icon(Icons.add),
                        ),
                      ) : imagesListToShow[position] is Map ? GestureDetector(
                        onTap: (){
                          showDialog(context: context,builder: (context){
                            return MyCustomDialog(title: Text(imagesListToShow[position]['PHOTO_NAME']),
                            actions: [
                              FlatButton(
                                child: Text('Delete'),
                                onPressed: ()async{
                                  await _photosOfAPI.deletePhotoOfFromDB(fileName: imagesListToShow[position]['PHOTO_NAME']).then((value){
                                    if(value){
                                      _photosOfAPI.deletePhotoOf(path: 'PhotosOf', photoName:imagesListToShow[position]['PHOTO_NAME']);
                                      Navigator.pop(context);
                                      setState(() {

                                      });
                                    }
                                  });
                                },
                              )
                            ],);
                          });
                        },
                        child: MyCustomImage(
                          image: "${imageLoc}PhotosOf/${imagesListToShow[position]['PHOTO_NAME']}",
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          secImg: '0',
                        ),
                      ) : imagesListToShow[position] is File? Image(
                        image: FileImage(imagesListToShow[position],),
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        fit: BoxFit.cover,
                      ) : Text('Error');
                    },
                  ),
                );
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
          show? FlatButton(
            child: Text('Save'),
            onPressed: ()async{
              _dialog("Loading...");
              for(int i=0; i<newImageFiles.length; i++){
               await _uploadImage.upload(newImageFiles[i],'OF').whenComplete(()async{
                 if(i == newImageFiles.length-1){
                   await _photosOfAPI.postListPhotosOf(centerID: widget.centerID,clinicID: widget.clinicID,myList: newImageNames).then((value){
                     if(value){
                       Navigator.pop(context);
                       setState(() {
                         show = false;
                         newImageNames.clear();
                         newImageFiles.clear();
                         imagesListToShow.clear();
                       });
                     }
                   });

                 }
               });
              }
            },
          ) : Container(),
        ],
      ),
    );
  }
  _dialog(String text){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$text'),
                )
              ],
            ),
          );
        });
  }

  _getImage() {
    return Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Material(
        color: Colors.grey[800],
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                  title: Text('Camera'),
                  leading: Icon(Icons.camera_alt),
                  onTap: ()async{
                    _dialog('Loading...');
                    _uploadImage = UploadImage();
                    File _image = await _uploadImage.getImage("C").whenComplete(()=>Navigator.pop(context));
                    if(_image != null){
                      setState(() {
                        show = true;
                      });
                      newImageNames.add(_uploadImage.imageName);
                      newImageFiles.add(_image);
                    }
                  }
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Gallery'),
                leading: Icon(Icons.image),
                  onTap: ()async{
                    _dialog('Loading...');
                    _uploadImage = UploadImage();
                    File _image = await _uploadImage.getImage("G").whenComplete(() => Navigator.pop(context));
                    if(_image != null){
                      setState(() {
                        show = true;
                      });
//                      imagesListToShow.add(_image);

                      newImageNames.add(_uploadImage.imageName);
                      newImageFiles.add(_image);
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    ));
  }



}
