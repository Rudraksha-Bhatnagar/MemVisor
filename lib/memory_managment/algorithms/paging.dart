// services/algorithms/paging.dart
import 'package:project/models/block.dart';
import 'package:project/models/process.dart';


void pagingAllocation(List<MemoryBlock> memoryBlocks, List<Process> processes) {
  int pageSize = 1; // Example page size (1 block)
  for (var process in processes) {
    int requiredPages = (process.size / pageSize).ceil();
    int allocatedPages = 0;
    for (var block in memoryBlocks) {
      if (block.isFree && block.size >= pageSize && allocatedPages < requiredPages) {
        block.isFree = false;
        block.process = process;
        allocatedPages++;
      }
    }
  }
}
