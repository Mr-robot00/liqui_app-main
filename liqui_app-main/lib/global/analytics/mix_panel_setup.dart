import 'package:liqui_app/global/constants/index.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelSetup {
  static final MixPanelSetup _singleton = MixPanelSetup._internal();

  factory MixPanelSetup() {
    return _singleton;
  }

  MixPanelSetup._internal();
  Mixpanel? mixPanel;

  Future<void> initialise() async {
    mixPanel = await Mixpanel.init(mixPanelToken, trackAutomaticEvents: true);
  }
}
final mixPanel = MixPanelSetup();
