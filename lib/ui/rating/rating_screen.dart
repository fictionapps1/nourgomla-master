import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/rating_with_comment.dart';
import '../../controllers/rating_controller.dart';
import '../../common_widgets/empty_view.dart';
import '../../consts/colors.dart';
import '../../common_widgets/loading_view.dart';
import '../../controllers/settings_controller.dart';

class RatingScreen extends StatefulWidget {
  final bool isUserRates;
  final int productId;
  RatingScreen({this.isUserRates = false, this.productId});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final SettingsController _settingsCon = Get.find<SettingsController>();

  RatingController _ratingCon;

  @override
  void initState() {
    _ratingCon = Get.put<RatingController>(
        RatingController(isUSerRates: widget.isUserRates,productId:widget.productId));
    _ratingCon.initRatingPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: APP_BG_COLOR,
        appBar: AppBar(
            title: Text('load_all_rates'.tr),
            centerTitle: true,
            backgroundColor: _settingsCon.color1),
        body: GetX<RatingController>(
          init: _ratingCon,
          builder: (con) => con.isLoading.value
              ? LoadingView()
              : _ratingCon.rates.isEmpty
                  ? EmptyView(text: 'no_rates_added_yet'.tr)
                  : Stack(
                      children: [
                        ListView.builder(
                          controller: _ratingCon.scrollController,
                          itemCount: _ratingCon.rates.length,
                          itemBuilder: (context, index) =>
                              RatingWithCommentWidget(
                            rate: _ratingCon.rates[index],
                            padding: 4,
                                isUserRates: widget.isUserRates,
                          ),
                        ),
                        if (con.loadingMore.value)
                          Positioned(
                              bottom: 0,
                              left: 40,
                              right: 40,
                              child: LoadingView())
                      ],
                    ),
        ));
  }
}
