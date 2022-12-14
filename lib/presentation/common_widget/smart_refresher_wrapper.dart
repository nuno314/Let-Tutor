import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'loading.dart';

export 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SmartRefresherWrapper {
  SmartRefresherWrapper._();

  static SmartRefresher build({
    required RefreshController controller,
    bool enablePullDown = true,
    bool enablePullUp = false,
    VoidCallback? onRefresh,
    VoidCallback? onLoading,
    required Widget child,
  }) {
    return SmartRefresher(
      header: MaterialClassicHeader(
        backgroundColor: AppColor.primaryColorLight,
      ),
      physics: const BouncingScrollPhysics(),
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          return const Align(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Loading(
                brightness: Brightness.light,
                radius: 10,
              ),
            ),
          );
        },
      ),
      child: child,
    );
  }
}
