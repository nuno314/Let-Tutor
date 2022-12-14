import '../envs.dart';

class Config {
  static final Config instance = Config._();

  Config._();

  AppConfig get appConfig => _appConfig;
  late AppConfig _appConfig;

  void setup(Map<String, dynamic> env) {
    _appConfig = AppConfig.from(env);
  }
}

class AppConfig {
  String envName;
  bool developmentMode;
  String appName;
  String baseApiLayer;

  AppConfig(
    this.envName,
    this.developmentMode,
    this.appName,
    this.baseApiLayer,
  );

  AppConfig.from(Map<String, dynamic> env)
      : envName = env[Env.environment],
        developmentMode = env[Env.developmentMode],
        appName = env[Env.appName],
        baseApiLayer = env[Env.baseApiLayer];

  bool get isDevBuild => envName == Env.devEnvName;
}
