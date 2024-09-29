// models/memory_block.dart
import 'process.dart';

class MemoryBlock {
  final String id;
  final int size;
  bool isFree;
  Process? process;

  MemoryBlock({
    required this.id,
    required this.size,
    this.isFree = true,
    this.process,
  });
}
