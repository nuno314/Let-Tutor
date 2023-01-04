import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/domain/entities/schedule_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import '../../../../common/constants.dart';
import '../../../../data/models/teacher.dart';
import '../../../base/base.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/controls_overlay.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../common_widget/tab_page_widget.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/tutor_bloc.dart';

part 'pages/booking_screen.dart';
part 'pages/tutor_detail_screen.dart';
part 'tutor.action.dart';

class TutorArgs {
  String? tutorId;
  Teacher? tutor;
  TutorArgs({
    this.tutorId,
    this.tutor,
  });
}

class TutorScreen extends StatefulWidget {
  final TutorArgs args;
  const TutorScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends StateBase<TutorScreen> {
  final _pageController = PageController();
  final infoRefreshController = RefreshController();
  final bookingRefreshController = RefreshController();

  @override
  TutorBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  void hideLoading() {
    infoRefreshController
      ..refreshCompleted()
      ..loadComplete();
    bookingRefreshController
      ..refreshCompleted()
      ..loadComplete();

    super.hideLoading();
  }

  final refreshController = RefreshController(initialRefresh: false);
  late VideoPlayerController vpController;

  late Teacher? tutor = widget.args.tutor;
  @override
  void initState() {
    vpController = VideoPlayerController.network(
      widget.args.tutor?.video ?? '',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    vpController.addListener(() {
      setState(() {});
    });
    vpController.setLooping(true);
    vpController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(tutor?.id);
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<TutorBloc, TutorState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          title: trans.tutor.capitalizeFirstofEach(),
          showHeaderImage: false,
          trans: trans,
          child: _buildTutorPage(state),
        );
      },
    );
  }

  Widget _buildTutorPage(TutorState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBox(
          child: DefaultTabController(
            length: 2,
            child: TabBar(
              onTap: _pageController.jumpToPage,
              labelColor: AppColor.primaryColor,
              tabs: [Tab(text: trans.detail), Tab(text: trans.book)],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColor.white,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              allowImplicitScrolling: true,
              children: [
                _buildTutorInfoPage(state),
                _buildBookingPage(state),
              ],
            ),
          ),
        )
      ],
    );
  }
}
