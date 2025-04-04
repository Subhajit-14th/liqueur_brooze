import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_page_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddPagesScreen extends StatelessWidget {
  const AddPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addPagesProvider = Provider.of<AddPageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Page",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Monserat',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Field
                  Text(
                    'Title',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  CommonTextField(
                    labelText: 'Enter Title',
                    hintText: 'enter title',
                    controller: addPagesProvider.titleController,
                  ),
                  SizedBox(height: height * 0.02),

                  /// Description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  /// Quill Editor
                  Container(
                    height: 140,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: quill.QuillEditor.basic(
                      controller: addPagesProvider.quillController,
                    ),
                  ),

                  /// Text Editor
                  quill.QuillSimpleToolbar(
                    controller: addPagesProvider.quillController,
                    config: const quill.QuillSimpleToolbarConfig(),
                  ),

                  /// Add Buttons
                  CommonButton(
                    width: double.infinity,
                    buttonText: 'Add',
                    buttonColor: AppColor.primaryColor,
                    buttonTextFontSize: 16,
                    onTap: () {
                      debugPrint(
                          'My title is: ${addPagesProvider.titleController.text}');
                      debugPrint(
                          'My description is: ${addPagesProvider.quillController.document.toPlainText()}');
                      context.read<AddPageProvider>().addPages(
                          context,
                          addPagesProvider.titleController.text,
                          addPagesProvider.quillController.document
                              .toPlainText());
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Loading Indicator Overlay
          if (context.watch<AddPageProvider>().isPagesAdded)
            Container(
              height: height,
              width: width,
              color: Colors.black.withAlpha(50), // Dim background
              child: const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballZigZag,
                    colors: [AppColor.primaryColor, AppColor.secondaryColor],
                    strokeWidth: 2,
                    backgroundColor: Colors.transparent,
                    pathBackgroundColor: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
