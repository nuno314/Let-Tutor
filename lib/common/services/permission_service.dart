import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../presentation/extentions/extention.dart';
import '../constants/locale/app_locale.dart';

export 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  static Future<bool> _requestPermission(
    Permission ps,
    BuildContext context,
  ) async {
    var status = await ps.status;

    if (status.isDenied) {
      status = await ps.request();
    }

    if ((Platform.isAndroid && status.isPermanentlyDenied) ||
        (Platform.isIOS && (status.isDenied || status.isPermanentlyDenied))) {
      unawaited(_showPermissionWarningDialog(context));
      return false;
    }

    return !status.isDenied && !status.isPermanentlyDenied;
  }

  //////////////////////////////////////////////////////////////////
  ///                         Publish api                        ///
  //////////////////////////////////////////////////////////////////

  static Future<bool> checkPermission(
    Permission ps,
    BuildContext context,
  ) async {
    final status = await ps.status;
    return !status.isDenied &&
        !status.isPermanentlyDenied &&
        !status.isRestricted;
  }

  static Future<bool> requestPermission(
    Permission ps,
    BuildContext context,
  ) async {
    var isGranted = await checkPermission(ps, context);
    if (!isGranted) {
      isGranted = await _requestPermission(ps, context);
    }
    return isGranted;
  }

  static Future<List<bool>> requestPermissions(
    List<Permission> pss,
    BuildContext context,
  ) async {
    final result = <bool>[];
    for (final ps in pss) {
      result.add(await requestPermission(ps, context));
    }
    return result;
  }

  static Future<void> _showPermissionWarningDialog(BuildContext context) {
    final appContsLocalization = AppConstantLocalization.of(context);
    return showActionDialog(
      context,
      title: appContsLocalization.haveNoPermission,
      titleBottomBtn: appContsLocalization.cancel,
      actions: {
        appContsLocalization.openSetting: openAppSettings,
      },
    );
  }
}
