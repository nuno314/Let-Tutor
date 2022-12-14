import 'package:injectable/injectable.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/response.dart';

import '../../../data/data_source/local/local_data_manager.dart';
import '../../../di/di.dart';
import '../../utils.dart';
import '../auth_service.dart';

@Singleton(as: AuthService)
class AppAuthService implements AuthService {
  final _localDataManager = injector.get<LocalDataManager>();
  final _authRepo = injector.get<AppApiService>();

  @override
  String? get token => _localDataManager.accessToken;

  @override
  Future<void> signOut() async {
    LogUtils.i('$runtimeType signOut');
    await _localDataManager.setAccessToken(null);
  }

  @override
  Future<LoginResponse?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final result = await _authRepo.client.authEmailLogin({
      'email': email,
      'password': password,
    });

    _localDataManager.notifyUserChanged(result?.user);

    _localDataManager.setAccessToken(result?.token?.accessToken);

    _localDataManager.setRefreshToken(result?.token?.refreshToken);

    return result;
  }

  @override
  Future<void> init() async {
    if (isSignedIn == true) {
      await refreshToken();
    } else {
      await _localDataManager.clearData();
    }
  }

  @override
  bool get isSignedIn => _localDataManager.refreshToken != null;

  @override
  Future<String?> refreshToken() async {
    final res = await _authRepo.client.refreshToken(
      {
        'refreshToken': _localDataManager.refreshToken,
        'timezone': 7,
      },
    );

    if (res?.token?.isValid == false) {
      throw RefreshTokenException();
    }
    _localDataManager.notifyUserChanged(res?.user);

    await _localDataManager.setAccessToken(res?.token?.accessToken);

    await _localDataManager.setRefreshToken(res?.token?.refreshToken);

    return res?.accessToken;
  }

  @override
  Future<LoginResponse?> loginWithFacebook({required String token}) async {
    final result = await _authRepo.client.authFacebookLogin({
      'access_token': token,
    });

    _localDataManager.notifyUserChanged(result?.user);

    _localDataManager.setAccessToken(result?.token?.accessToken);

    _localDataManager.setRefreshToken(result?.token?.refreshToken);

    return result;
  }

  @override
  Future<LoginResponse?> loginWithGoogle({
    required String token,
  }) async {
    final result = await _authRepo.client.authGoogleLogin({
      'access_token': token,
    });

    _localDataManager.notifyUserChanged(result?.user);

    _localDataManager.setAccessToken(result?.token?.accessToken);

    _localDataManager.setRefreshToken(result?.token?.refreshToken);

    return result;
  }

  @override
  Future<LoginResponse?> loginWithPhoneNumber({
    required String phoneNumber,
    required String password,
  }) async {
    final result = await _authRepo.client.authPhoneNumberLogin({
      'phone': phoneNumber,
      'password': password,
    });

    _localDataManager.notifyUserChanged(result?.user);

    _localDataManager.setAccessToken(result?.token?.accessToken);

    _localDataManager.setRefreshToken(result?.token?.refreshToken);

    return result;
  }
}

class RefreshTokenException implements Exception {
  final String message;

  RefreshTokenException({this.message = 'Auto refresh token failed'});
}
