import 'package:project/models/block.dart' as block;
import 'package:project/models/process.dart';

// Function to find free space (First Fit)
int findFirstFitSpace(List<block.MemoryBlock> memoryBlocks, int processSize) {
  for (int i = 0; i <= memoryBlocks.length - processSize; i++) {
    bool hasSpace = true;

    // Check if there is contiguous free space
    for (int j = i; j < i + processSize; j++) {
      if (!memoryBlocks[j].isFree) {
        hasSpace = false;
        break;
      }
    }

    if (hasSpace) return i;
  }
  return -1;
}

// First Fit Allocation Function
void firstFitAllocation(List<block.MemoryBlock> memoryBlocks, List<Process> processes) {
  for (var process in processes) {
    int startBlock = findFirstFitSpace(memoryBlocks, process.size);

    if (startBlock != -1) {
      for (int i = startBlock; i < startBlock + process.size; i++) {
        memoryBlocks[i].isFree = false;
        memoryBlocks[i].process = process;
      }
    } else {
      print('Not enough free space for process ${process.name}');
    }
  }
}
