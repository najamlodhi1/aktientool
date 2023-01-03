class HistoricalData {
  final String date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double adjClose;
  final double volume;
  final double unadjustedVolume;
  final double change;
  final double changePercent;
  final double vwap;
  final String label;
  final double changeOverTime;

  HistoricalData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adjClose,
    required this.volume,
    required this.unadjustedVolume,
    required this.change,
    required this.changePercent,
    required this.vwap,
    required this.label,
    required this.changeOverTime,
  });

  factory HistoricalData.fromJson(Map<String, dynamic> json) {
    return HistoricalData(
      date: json['date'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
      adjClose: json['adjClose'],
      volume: json['volume'],
      unadjustedVolume: json['unadjustedVolume'],
      change: json['change'],
      changePercent: json['changePercent'],
      vwap: json['vwap'],
      label: json['label'],
      changeOverTime: json['changeOverTime'],
    );
  }
}

class Data {
  final String symbol;
  final List<HistoricalData> historical;

  Data({
    required this.symbol,
    required this.historical,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var historicalList = json['historical'] as List;
    List<HistoricalData> historicalDataList =
        historicalList.map((i) => HistoricalData.fromJson(i)).toList();

    return Data(
      symbol: json['symbol'],
      historical: historicalDataList,
    );
  }
}
