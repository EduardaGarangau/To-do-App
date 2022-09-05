import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSignup extends StatefulWidget {
  final void Function(File) onPickedImage;
  const ImageSignup({
    required this.onPickedImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSignup> createState() => _ImageSignupState();
}

class _ImageSignupState extends State<ImageSignup> {
  File? image;

  Future<void> pickImage() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 120,
      maxHeight: 150,
    );

    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
      });
    }

    widget.onPickedImage(image!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickImage,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        backgroundImage: image != null
            ? FileImage(image!)
            : Image.asset(
                'lib/assets/images/lup.JPG',
              ).image,
      ),
    );
  }
}
