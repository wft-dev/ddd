import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daily_dairy_diary/amplifyconfiguration.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';

//  AWSAmplifyConfigure
class AWSAmplifyConfigure {
  static Future<bool> configureAWSAmplify() async {
    final apiPlugin = AmplifyAPI(modelProvider: ModelProvider.instance);
    final authPlugin = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();

    await Amplify.addPlugins([authPlugin, apiPlugin, storage]);
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
