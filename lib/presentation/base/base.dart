import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/client_info.dart';
import '../../common/constants/app_locale.dart';
import '../../common/services/auth_service.dart';
import '../../common/utils.dart';
import '../../data/data_source/local/local_data_manager.dart';
import '../../data/data_source/remote/app_api_service.dart';
import '../../di/di.dart';
import '../common_bloc/app_data_bloc.dart';
import '../common_widget/export.dart';
import '../extentions/extention.dart';
import '../route/route_list.dart';
import 'package:dio/dio.dart';

part 'bloc_base.dart';
part 'state_base/state_base.dart';
part 'state_base/state_base.error_handler.dart';
part 'state_base/state_base.ext.dart';
