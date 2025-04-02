import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/add_page_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class EditPagesScreen extends StatefulWidget {
  const EditPagesScreen(
      {super.key,
      required this.pageId,
      required this.pageTitleName,
      required this.pageDescription});

  final String pageId;
  final String pageTitleName;
  final String pageDescription;

  @override
  State<EditPagesScreen> createState() => _EditPagesScreenState();
}

class _EditPagesScreenState extends State<EditPagesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddPageProvider>(context, listen: false)
        .updateTitleController
        .text = widget.pageTitleName;
    Provider.of<AddPageProvider>(context, listen: false)
        .updateQuillController
        .document = quill.Document()..insert(0, widget.pageDescription);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final addPagesProvider = Provider.of<AddPageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Page",
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
                    controller: addPagesProvider.updateTitleController,
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
                      controller: addPagesProvider.updateQuillController,
                    ),
                  ),

                  /// Text Editor
                  quill.QuillSimpleToolbar(
                    controller: addPagesProvider.updateQuillController,
                    config: const quill.QuillSimpleToolbarConfig(),
                  ),

                  /// Add Buttons
                  CommonButton(
                    width: double.infinity,
                    buttonText: 'Update',
                    buttonColor: AppColor.primaryColor,
                    buttonTextFontSize: 16,
                    onTap: () {
                      debugPrint(
                          'My title is: ${addPagesProvider.updateTitleController.text}');
                      debugPrint(
                          'My description is: ${addPagesProvider.updateQuillController.document.toPlainText()}');
                      context.read<AddPageProvider>().updatePage(
                            context,
                            widget.pageId,
                            addPagesProvider.updateTitleController.text,
                            addPagesProvider.updateQuillController.document
                                .toPlainText(),
                          );
                    },
                  ),
                ],
              ),
            ),
          ),

          /// Loading Indicator Overlay
          if (context.watch<AddPageProvider>().isPagesUpdate)
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
