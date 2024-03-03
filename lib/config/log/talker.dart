import 'package:talker_flutter/talker_flutter.dart';

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

class CrashlyticsTalkerObserver extends TalkerObserver {
  const CrashlyticsTalkerObserver();

  @override
  void onError(TalkerError err) {
    // FirebaseCrashlytics.instance.recordError(
    //   err.error,
    //   err.stackTrace,
    //   reason: err.message,
    // );
  }

  @override
  void onException(TalkerException err) {
    // FirebaseCrashlytics.instance.recordError(
    //   err.exception,
    //   err.stackTrace,
    //   reason: err.message,
    // );
  }
}
