import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseServerServices {
  static Future<void> initializeParse() async {
    await Parse().initialize(
      'PKWZ2GHXXO98SD7OU3kxV6nqgW177SoMW6tqkOT4',
      'https://parseapi.back4app.com/',
      clientKey: '9qp5rdWVv1kplCmCuDTApmkH8uEvJFHYpc2QmUsl',
      autoSendSessionId: true,
      debug: true,
    );
  }
}
