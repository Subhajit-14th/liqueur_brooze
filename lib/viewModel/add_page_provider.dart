import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:liqueur_brooze/controller/PagesControllers/pages_controllers.dart';
import 'package:liqueur_brooze/model/PagesModel/all_pages_api_res_model.dart'
    as all_pages;
import 'package:liqueur_brooze/model/PagesModel/crreate_page_api_res_model.dart';
import 'package:liqueur_brooze/model/PagesModel/delete_pages_api_res_model.dart';
import 'package:liqueur_brooze/model/PagesModel/update_page_api_res_model.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';

class AddPageProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final TextEditingController _updateTitleController = TextEditingController();
  TextEditingController get updateTitleController => _updateTitleController;

  final quill.QuillController _quillController = quill.QuillController.basic();
  quill.QuillController get quillController => _quillController;

  final quill.QuillController _updateQuillController =
      quill.QuillController.basic();
  quill.QuillController get updateQuillController => _updateQuillController;

  all_pages.AllPagesApiResModel _allPagesApiResModel =
      all_pages.AllPagesApiResModel();
  List<all_pages.Data>? _allPages = [];
  List<all_pages.Data>? get allPages => _allPages;

  CreatePagesApiResModel _createPagesApiResModel = CreatePagesApiResModel();
  DeletePagesApiResModel _deletePagesApiResModel = DeletePagesApiResModel();
  UpdatePagesApiResModel _updatePagesApiResModel = UpdatePagesApiResModel();

  final PagesControllers _pagesControllers = PagesControllers();

  bool _isPageLoad = false;
  bool get isPageLoad => _isPageLoad;

  bool _isPagesAdded = false;
  bool get isPagesAdded => _isPagesAdded;

  bool _isPagesUpdate = false;
  bool get isPagesUpdate => _isPagesUpdate;

  /// get all pages
  void getAllPages(context) async {
    _isPageLoad = true;
    notifyListeners();
    _allPagesApiResModel =
        await _pagesControllers.getAllPages(context: context);
    if (_allPagesApiResModel.status == 1) {
      _allPages?.clear();
      _isPageLoad = false;
      _allPages = _allPagesApiResModel.data;
    } else {
      _isPageLoad = false;
    }
    notifyListeners();
  }

  /// add pages
  void addPages(context, title, description) async {
    _isPagesAdded = true;
    notifyListeners();
    _createPagesApiResModel = await _pagesControllers.createPages(
        context: context, title: title, description: description);
    if (_createPagesApiResModel.status == 1) {
      _isPagesAdded = false;
      getAllPages(context);
      _titleController.clear();
      _quillController.document = quill.Document();
      showSnackBar(context, "${_createPagesApiResModel.message}");
    } else {
      _isPagesAdded = false;
    }
    notifyListeners();
  }

  /// delete page
  void deletePage(context, pagesId) async {
    _deletePagesApiResModel =
        await _pagesControllers.deletePages(context: context, pagesId: pagesId);
    if (_deletePagesApiResModel.status == 1) {
      getAllPages(context);
    } else {
      getAllPages(context);
    }
    notifyListeners();
  }

  /// update page
  void updatePage(context, pageId, title, description) async {
    _isPagesUpdate = true;
    notifyListeners();
    _updatePagesApiResModel = await _pagesControllers.updatePages(
        context: context,
        pagesId: pageId,
        title: title,
        description: description);
    if (_updatePagesApiResModel.status == 1) {
      _isPagesUpdate = false;
      getAllPages(context);
      _updateTitleController.clear();
      _updateQuillController.document = quill.Document();
      showSnackBar(context, "${_updatePagesApiResModel.message}");
    } else {
      _isPagesUpdate = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    super.dispose();
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.secondaryColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 50,
        left: 20,
        right: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
