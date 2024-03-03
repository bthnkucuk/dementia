import 'package:talker_flutter/talker_flutter.dart';

import 'crashlitics_observer.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: true,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: 200,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),
  observer: const CrashlyticsTalkerObserver(),
);
