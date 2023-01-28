import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FMPKEY', obfuscate: true)
  static final fmpKey = _Env.fmpKey;
  @EnviedField(varName: 'APIKEY', obfuscate: true)
  static final apiKey = _Env.apiKey;
  @EnviedField(varName: 'SECRETKEY', obfuscate: true)
  static final secretKey = _Env.secretKey;
  @EnviedField(varName: 'NIKESPRICEID', obfuscate: true)
  static final nikesPriceId = _Env.nikesPriceId;
  @EnviedField(varName: 'FBWEBAPIKEY', obfuscate: true)
  static final fbWebApiKey = _Env.fbWebApiKey;
  @EnviedField(varName: 'FBANDROIDAPIKEY', obfuscate: true)
  static final fbAndroidApiKey = _Env.fbAndroidApiKey;
}
