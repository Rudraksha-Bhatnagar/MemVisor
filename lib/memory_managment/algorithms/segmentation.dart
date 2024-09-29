// services/allocation_algorithms/segmentation.dart
import 'package:project/models/block.dart';
import 'package:project/models/process.dart';


void segmentationAllocation(List<MemoryBlock> memoryBlocks, List<Process> processes) {
  int segmentSize = 1; // Example segment size (1 block)
  for (var process in processes) {
    int requiredSegments = (process.size / segmentSize).ceil();
    int allocatedSegments = 0;
    for (var block in memoryBlocks) {
      if (block.isFree && block.size >= segmentSize && allocatedSegments < requiredSegments) {
        block.isFree = false;
        block.process = process;
        allocatedSegments++;
      }
    }
  }
}
