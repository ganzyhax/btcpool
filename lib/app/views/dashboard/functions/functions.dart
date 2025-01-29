class DashboardFunctions {
//================================================================================================================================
  List<DateTime> getLastHourDivided(int segments) {
    List<DateTime> result = [];
    DateTime now = DateTime.now();

    // Calculate the start time
    DateTime startTime = now.subtract(Duration(minutes: now.minute % segments));

    // Loop to generate the times
    for (int i = 0; i < segments; i++) {
      // Calculate the time for this segment
      DateTime segmentTime =
          startTime.subtract(Duration(minutes: i * (60 ~/ segments)));

      // Convert to UTC
      result.add(segmentTime.toUtc());
    }

    return result;
  }
//================================================================================================================================

  List<DateTime> getLast24HoursDivided(int segments) {
    List<DateTime> result = [];
    DateTime now = DateTime.now();

    // Calculate the start time (24 hours ago)
    DateTime startTime = now.subtract(const Duration(hours: 24));

    // Loop to generate the times
    for (int i = 0; i < segments; i++) {
      // Calculate the time for this segment
      DateTime segmentTime =
          startTime.add(Duration(minutes: (i * (24 * 60) ~/ segments)));

      // Convert to UTC
      result.add(segmentTime.toUtc());
    }

    return result;
  }
//================================================================================================================================

  List<DateTime> getLastMonthDivided(int segments) {
    List<DateTime> result = [];
    DateTime now = DateTime.now();

    // Calculate the start time (one month ago)
    DateTime startTime = DateTime(
        now.year, now.month - 1, now.day, now.hour, now.minute, now.second);

    // Calculate the number of days in the previous month
    int daysInPreviousMonth = DateTime(now.year, now.month, 0).day;

    // Loop to generate the times
    for (int i = 0; i < segments; i++) {
      // Calculate the time for this segment
      DateTime segmentTime =
          startTime.add(Duration(days: (i * daysInPreviousMonth) ~/ segments));

      // Convert to UTC
      result.add(segmentTime.toUtc());
    }

    return result;
  }

  //================================================================================================================================
  List hashrateConverter(double hash, int thFix) {
    double th = hash / 1e6;
    if (th < 1000) {
      return [th.toStringAsFixed(thFix), 'TH/s'];
    }
    if (th >= 1000) {
      double ph = th / 1000;
      return [ph.toStringAsFixed(2), 'PH/s'];
    }
    if (th >= 1000000) {
      double eh = th / 1000000;
      return [eh.toStringAsFixed(2), 'EH/s'];
    }
    double ph = th / 1000;
    return [ph.toStringAsFixed(2), 'PH/s'];
  }

  List hashrateConverterLTC(double hash, int thFix) {
    double gh = hash / 1000;

    return [gh.toStringAsFixed(2), 'GH/s'];
  }
}
