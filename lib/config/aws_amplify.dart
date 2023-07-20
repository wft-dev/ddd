import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../amplifyconfiguration.dart';
import '../models/ModelProvider.dart';

//  AWSAmplifyConfigure
class AWSAmplifyConfigure {
  static Future<bool> configureAWSAmplify() async {
    final apiPlugin = AmplifyAPI(modelProvider: ModelProvider.instance);
    final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin, apiPlugin]);
    // You can use addPlugins if you are going to be adding multiple plugins
    // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
      return true;
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
      return false;
    }
  }
}
