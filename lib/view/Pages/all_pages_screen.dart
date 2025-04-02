import 'package:flutter/material.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/view/Pages/add_pages_screen.dart';
import 'package:liqueur_brooze/view/Pages/edit_pages_screen.dart';
import 'package:liqueur_brooze/viewModel/add_page_provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class AllPagesScreen extends StatefulWidget {
  const AllPagesScreen({super.key});

  @override
  State<AllPagesScreen> createState() => _AllPagesScreenState();
}

class _AllPagesScreenState extends State<AllPagesScreen> {
  @override
  void initState() {
    super.initState();

    /// Call getCategoryList when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddPageProvider>(context, listen: false).getAllPages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Pages",
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
      body: Column(
        children: [
          /// Heading items and add pages buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Pages',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserat',
                  ),
                ),
                CommonButton(
                  width: 130,
                  height: 40,
                  buttonText: 'Add Pages',
                  buttonTextFontSize: 12,
                  buttonColor: AppColor.primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPagesScreen()));
                  },
                ),
              ],
            ),
          ),

          /// All Pages List
          Consumer<AddPageProvider>(builder: (context, provider, child) {
            if (provider.isPageLoad) {
              return const Center(
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
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: provider.allPages?.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPagesScreen(
                                    pageId: '${provider.allPages?[index].sId}',
                                    pageTitleName:
                                        "${provider.allPages?[index].title}",
                                    pageDescription:
                                        "${provider.allPages?[index].description}",
                                  )));
                    },
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(50),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            spacing: 18,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'SL',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Monserat',
                                    ),
                                  ),
                                ],
                              ),

                              /// Page Name
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Coupon Type
                                    Text(
                                      'Pages',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    Text(
                                      '${provider.allPages?[index].title}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Monserat',
                                      ),
                                    ),
                                    SizedBox(height: 10),

                                    /// Page description
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Coupon Type
                                        Text(
                                          'Description',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Monserat',
                                          ),
                                        ),
                                        Text(
                                          '${provider.allPages?[index].description}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Monserat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showDeleteDialog(
                                context, "${provider.allPages?[index].sId}");
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(14),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String pagesId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Pages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat',
            ),
          ),
          content: Text(
            "Are you sure you want to delete this page?",
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Monserat',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Monserat',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AddPageProvider>(context, listen: false)
                    .deletePage(context, pagesId);
                Navigator.of(context).pop(); // Close the dialog after deleting
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Monserat',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
