import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY', obfuscate: true)
  static final openAIApiKey = _Env.openAIApiKey;
}
