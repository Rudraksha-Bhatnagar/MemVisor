import 'package:project/models/block.dart' as block;
import 'package:project/models/process.dart';

// Helper function to calculate next power of two
int nextPowerOfTwo(int size) {
  int power = 1;
  while (power < size) {
    power *= 2;
  }
  return power;
}

// Function to find space for the Buddy System
int findBuddyFitSpace(List<block.MemoryBlock> memoryBlocks, int processSize) {
  int buddySize = nextPowerOfTwo(processSize);

  for (int i = 0; i <= memoryBlocks.length - buddySize; i++) {
    bool hasSpace = true;
    for (int j = i; j < i + buddySize; j++) {
      if (!memoryBlocks[j].isFree) {
        hasSpace = false;
        break;
      }
    }

    if (hasSpace) return i;
  }
  return -1;
}

// Buddy System Allocation Function
void buddySystemAllocation(List<block.MemoryBlock> memoryBlocks, List<Process> processes) {
  for (var process in processes) {
    int startBlock = findBuddyFitSpace(memoryBlocks, process.size);

    if (startBlock != -1) {
      int buddySize = nextPowerOfTwo(process.size);
      for (int i = startBlock; i < startBlock + buddySize; i++) {
        memoryBlocks[i].isFree = false;
        memoryBlocks[i].process = process;
      }
    } else {
      print('Not enough free space for process ${process.name}');
    }
  }
}
