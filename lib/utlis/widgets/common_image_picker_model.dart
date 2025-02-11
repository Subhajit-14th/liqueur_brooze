import 'package:flutter/material.dart';

void showImagePickerBottomSheet({
  required BuildContext context,
  required VoidCallback onCameraTap,
  required VoidCallback onGalleryTap,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                onCameraTap();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                onGalleryTap();
              },
            ),
          ],
        ),
      );
    },
  );
}
