import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddPageScreen extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController get quillController => _quillController;

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    super.dispose();
  }
}
