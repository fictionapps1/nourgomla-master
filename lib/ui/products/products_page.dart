import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/cart_count_widget.dart';
import '../../common_widgets/drawer.dart';
import '../../common_widgets/empty_view.dart';
import '../../common_widgets/custom_text.dart';
import '../../consts/colors.dart';
import '../../controllers/filter_contoller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/categories_view_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../responsive_setup/responsive_builder.dart';
import '../../services/api_calls/products_service.dart';
import '../../ui/filter/filter_screen.dart';
import '../../ui/products/widgets/products_categories_view.dart';
import '../../ui/products/widgets/products_view.dart';
import '../../common_widgets/loading_view.dart';
import 'package:flutter/rendering.dart';

class ProductsPage extends StatefulWidget {
  final int categoryId;
  final String vendorId;
  final String title;
  final String categoryImage;

  ProductsPage({
    @required this.categoryId,
    this.vendorId,
    this.title,
    this.categoryImage,
  });

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsService _productsService = ProductsService.instance;
  final FilterController _filterController = Get.put(FilterController());

  CategoriesViewController productsController =
      Get.put<CategoriesViewController>(CategoriesViewController());
  final SettingsController _settingsCon = Get.find<SettingsController>();
  ScrollController _scrollController = ScrollController();
  List<Product> _products = [];
  Future _productsFuture;
  Future _categoriesFuture;
  int _startIndex = 0;
  int _itemsPerPage = 10;
  int _totalCount = 0;
  bool isLoading = false;
  List<Category> categories = [];
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initCategories();
    initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreProducts();
      }
    });
    super.initState();
  }

  initCategories() async {
    _categoriesFuture = productsController.getCategories(
     parentId: widget.categoryId,
    vendorId: widget.vendorId,
    );
    categories = await _categoriesFuture;
  }

  initData() async {
    _startIndex = 0;
    _products = [];
    _productsFuture = _productsService.getProducts(
      categoryId: widget.categoryId,
      startIndex: _startIndex,
      itemsPerPage: _itemsPerPage,
      sortBy: _filterController.selectedOrder,
      type: _filterController.selectedType,
      company: _filterController.selectedCompany,
      trademark: _filterController.selectedTrademark,
    );

    final Map<String, dynamic> productsData = await _productsFuture;
    _products = productsData['products'];
    _totalCount = productsData['total_count'];
    setState(() {
      _startIndex = _startIndex + _itemsPerPage;
    });
  }

  getMoreProducts() async {
    if (_startIndex < _totalCount) {
      setState(() {
        isLoading = true;
        print(isLoading);
      });
      final Map<String, dynamic> productsData =
          await _productsService.getProducts(
        categoryId: widget.categoryId,
        startIndex: _startIndex,
        itemsPerPage: _itemsPerPage,
        sortBy: _filterController.selectedOrder,
        type: _filterController.selectedType,
        company: _filterController.selectedCompany,
        trademark: _filterController.selectedTrademark,
      );
      setState(() {
        _products.addAll(productsData['products']);
        _startIndex = _startIndex + _itemsPerPage;
        isLoading = false;
        print(isLoading);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesViewController>(
      init: CategoriesViewController(),
      builder: (controller) {
        return SafeArea(
          child: ResponsiveBuilder(builder: (context, sizingInfo) {
            return Scaffold(
              backgroundColor: APP_BG_COLOR,
              drawer: AppDrawer(),
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: _settingsCon.color1,
                    title: CustomText(
                      text: widget.title??'',
                      size: 20,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),

                    // actions: [CartCountWidget()],
                  ),
                  SliverAppBar(
                    pinned: true,
                    elevation: 0,
                    backgroundColor: _settingsCon.color1,
                    // title: InkWell(
                    //   onTap: () {
                    //     Get.to(FilterScreen(),
                    //         duration: Duration(milliseconds: 500));
                    //   },
                    //   child: Container(
                    //     width: 90,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.white),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 4, vertical: 2),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Icon(
                    //             Icons.filter_alt_outlined,
                    //           ),
                    //           CustomText(
                    //             text: 'filter'.tr,
                    //             size: 16,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.filter_alt,
                          color: Colors.black87,
                        ),
                        onPressed: () async {
                          bool applyFilter = await Get.to(() => FilterScreen(),
                              duration: Duration(milliseconds: 500));
                          if (applyFilter) {
                            initData();
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: InkWell(
                          onTap: () {
                            controller.isList.toggle();
                          },
                          child: Obx(
                            () => Icon(
                              controller.isList.value
                                  ? Icons.list
                                  : Icons.grid_view,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      CartCountWidget(),
                    ],
                  ),
                  if (categories.isNotEmpty && categories.length > 0)
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: APP_BG_COLOR,
                      pinned: true,
                      elevation: 1,
                      toolbarHeight: 48,
                      title: Container(
                        width: sizingInfo.screenWidth,
                        height: 40,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 5),
                          itemBuilder: (context, index) {
                            Category category = categories[index];
                            return Container(
                              width: 150,
                              height: 40,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: _settingsCon.color4,
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: GetBuilder<LanguageController>(
                                    init: Get.find(),
                                    builder: (con) {
                                      return Text(
                                          con.lang == 'ar'
                                              ? category.nameAr
                                              : category.nameEn,
                                          style:
                                              TextStyle(color: Colors.white));
                                    }),
                                onPressed: () => navigateToNext(category),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (categories.length > 0)
                            ProductsCategoriesView(
                              categories: categories,
                              vendorId: widget.vendorId,
                              categoryId: widget.categoryId,
                              categoryImage: widget.categoryImage,
                            ),
                          FutureBuilder<Map<String, dynamic>>(
                            future: _productsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.connectionState ==
                                      ConnectionState.done) {
                                if (snapshot.data.isNotEmpty) {
                                  return Stack(
                                    children: [
                                      ProductsView(
                                        products: _products,
                                        categoryImage: widget.categoryImage,
                                        applyFilter: () {
                                          initData();
                                        },
                                      ),
                                      if (isLoading)
                                        Positioned(
                                            bottom: 0,
                                            left: 40,
                                            right: 40,
                                            child: LoadingView()),
                                    ],
                                  );
                                } else
                                  return EmptyView();
                              } else
                                return LoadingView();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future navigateToNext(Category category) {
    return Get.to(
      () => GetBuilder<LanguageController>(
          init: Get.find(),
          builder: (con) {
            return ProductsPage(
              categoryImage: widget.categoryImage,
              categoryId: category.id,
              vendorId: widget.vendorId,
              title: con.lang == 'ar' ? category.nameAr : category.nameEn,
            );
          }),
      preventDuplicates: false,
    );
  }
}
