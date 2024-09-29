import 'package:project/models/block.dart' as block;
import 'package:project/models/process.dart';

// Function to find the smallest free space (Best Fit)
int findBestFitSpace(List<block.MemoryBlock> memoryBlocks, int processSize) {
  int bestStart = -1;
  int bestSize = memoryBlocks.length + 1;  // Set to an impossibly large value

  // Traverse the entire memory block list
  for (int i = 0; i < memoryBlocks.length; i++) {
    // Look for free blocks
    if (memoryBlocks[i].isFree) {
      int freeBlockSize = 0;
      int startBlock = i;

      // Count consecutive free blocks starting from 'i'
      while (i < memoryBlocks.length && memoryBlocks[i].isFree) {
        freeBlockSize++;
        i++;  // Move to the next block
      }

      // Check if this free block fits the process size and is smaller than the best one found so far
      if (freeBlockSize >= processSize && freeBlockSize < bestSize) {
        bestStart = startBlock;
        bestSize = freeBlockSize;
      }
    }
  }

  return bestStart;  // Return the best starting position found, or -1 if none
}

// Best Fit Allocation Function
void bestFitAllocation(List<block.MemoryBlock> memoryBlocks, List<Process> processes) {
  for (var process in processes) {
    int startBlock = findBestFitSpace(memoryBlocks, process.size);

    if (startBlock != -1) {
      // Allocate memory to the process
      for (int i = startBlock; i < startBlock + process.size; i++) {
        memoryBlocks[i].isFree = false;
        memoryBlocks[i].process = process;
      }
      print('Process ${process.name} allocated at block $startBlock');
    } else {
      // If no space found
      print('Not enough free space for process ${process.name}');
    }
  }
}
