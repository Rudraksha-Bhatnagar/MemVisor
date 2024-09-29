// models/segment_table_model.dart

class SegmentTableModel {
  final int segmentNumber;
  final int baseAddress;
  final int limit;

  SegmentTableModel({
    required this.segmentNumber,
    required this.baseAddress,
    required this.limit,
  });
}
