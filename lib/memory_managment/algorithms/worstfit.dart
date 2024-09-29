import 'package:project/models/block.dart' as block;
import 'package:project/models/process.dart';

// Function to find the largest free space (Worst Fit)
int findWorstFitSpace(List<block.MemoryBlock> memoryBlocks, int processSize) {
  int worstStart = -1;
  int worstSize = 0;

  for (int i = 0; i <= memoryBlocks.length - processSize; i++) {
    int freeBlockSize = 0;
    for (int j = i; j < memoryBlocks.length && memoryBlocks[j].isFree; j++) {
      freeBlockSize++;
      if (freeBlockSize >= processSize && freeBlockSize > worstSize) {
        worstStart = i;
        worstSize = freeBlockSize;
      }
    }
  }
  return worstStart;
}

// Worst Fit Allocation Function
void worstFitAllocation(List<block.MemoryBlock> memoryBlocks, List<Process> processes) {
  for (var process in processes) {
    int startBlock = findWorstFitSpace(memoryBlocks, process.size);

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
