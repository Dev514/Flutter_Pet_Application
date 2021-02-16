import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class admin extends StatefulWidget {
  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  List<String> category = ['Cat', 'Dog', 'Parrot', 'Rabbit', 'Horse'];
  String _selectedCategory;
  File videoFile;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  File _image;
  String imageUrl;
  var itemcount;
  final petname = TextEditingController();
  final petdesc = TextEditingController();
  final petprice = TextEditingController();
  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            imagefield(),
            SizedBox(
              height: 20,
            ),
            nameTextfield(),
            SizedBox(
              height: 20,
            ),
            categoryField(),
            SizedBox(
              height: 20,
            ),
            descTextfield(),
            SizedBox(
              height: 20,
            ),
            priceTextfield(),
            SizedBox(
              height: 20,
            ),
            uploadButton(),
          ],
        ),
      ),
    );
  }

  Widget imagefield() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                child: (_controller != null)
                    ? FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(
                              child: AspectRatio(
                                aspectRatio: 16 / 12,
                                child: VideoPlayer(_controller),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })
                    : Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeE5rA3nKAxrXTaKfQU6bJiD_w-1OrL4Tg-g&usqp=CAU',
                        fit: BoxFit.fill,
                      ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 90, left: 80),
                  child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        getVideo();
                      })),
            ],
          ),
        ],
      ),
    );
  }

  Future getImages() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget nameTextfield() {
    return TextFormField(
        controller: petname,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.pets,
            color: Colors.orange,
          ),
          labelText: "Pet Name",
          hintText: "ABC",
        ));
  }

  Widget descTextfield() {
    return TextFormField(
        controller: petdesc,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.description,
            color: Colors.orange,
          ),
          labelText: "Pet Description",
          hintText: "Description",
        ));
  }

  Widget priceTextfield() {
    return TextFormField(
        controller: petprice,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            Icons.money,
            color: Colors.orange,
          ),
          labelText: "Pet Price",
          hintText: "Price in dollar",
        ));
  }

  Widget categoryField() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            icon: Icon(
              Icons.category,
              color: Colors.orange,
            ),
            focusColor: Colors.deepOrange,
            hint: Text('Please choose a Category'),
            value: _selectedCategory,
            items: category.map(
              (location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              },
            ).toList(),
            onChanged: (location) {
              setState(() {
                _selectedCategory = location;
              });
            }),
      ),
    );
  }

  Widget uploadButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        child: Container(
          height: 55,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.orange),
          child: Center(
            child: Text(
              "UPLOAD",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        onTap: () async {
          final ref = fb.reference().child('admin/product');

          ref.push().child('').set({
            'name': petname.text,
            'description': petdesc.text,
            'category': _selectedCategory,
            'price': petprice.text,
          });

          _showMyDialog();
        },
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucessfully uploaded'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The pet data uploaded sucessfully'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getVideo(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await _storage.ref().child('folderName/imageName').putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  Future getVideo() async {
    Future<File> _videoFile =
        ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      setState(() {
        videoFile = file;
        _controller = VideoPlayerController.file(videoFile)
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
          });

        // Initialize the controller and store the Future for later use.
        _initializeVideoPlayerFuture = _controller.initialize();

        // Use the controller to loop the video.
        _controller.setLooping(true);
        _controller.setVolume(0.7);
      });
    });
  }
}
