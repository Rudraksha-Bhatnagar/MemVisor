import 'package:flutter/material.dart';
import 'package:project/models/block.dart';
import 'package:project/models/process.dart';
import 'algorithms/firstfit.dart';
import 'algorithms/bestfit.dart';
import 'algorithms/worstfit.dart';
import 'algorithms/buddy.dart';
import 'algorithms/paging.dart';
import 'algorithms/segmentation.dart';

class MemoryManager extends ChangeNotifier {
  List<MemoryBlock> memoryBlocks = [];
  List<Process> processes = [];

  String selectedAlgorithm = 'First Fit';

  MemoryManager() {
    initializeMemory();
  }

  void initializeMemory() {
    memoryBlocks = List.generate(100, (index) {
      return MemoryBlock(id: 'Block ${index + 1}', size: 1, isFree: true);
    });
    notifyListeners();
  }

  // Add a new process and allocate memory for only this process
  void addProcess(String name, int size) {
    Process newProcess = Process(name, size);
    processes.add(newProcess);

    // Allocate memory for only the new process
    allocateMemoryForProcess(newProcess);
    notifyListeners();
  }

  // Allocate memory for a specific process based on the selected algorithm
  void allocateMemoryForProcess(Process process) {
    switch (selectedAlgorithm) {
      case 'First Fit':
        int startBlock = findFirstFitSpace(memoryBlocks, process.size);
        if (startBlock != -1) {
          for (int i = startBlock; i < startBlock + process.size; i++) {
            memoryBlocks[i].isFree = false;
            memoryBlocks[i].process = process;
          }
        } else {
          print('Not enough free space for process ${process.name}');
        }
        break;
      case 'Best Fit':
        bestFitAllocation(memoryBlocks, [process]);
        break;
      case 'Worst Fit':
        worstFitAllocation(memoryBlocks, [process]);
        break;
      case 'Buddy System':
        buddySystemAllocation(memoryBlocks, [process]);
        break;
      case 'Paging':
        pagingAllocation(memoryBlocks, [process]);
        break;
      case 'Segmentation':
        segmentationAllocation(memoryBlocks, [process]);
        break;
      default:
        firstFitAllocation(memoryBlocks, [process]);
    }
  }

  // Delete a specific process and free up its memory blocks
  void deleteProcess(String processName) {
    // Remove the process from the list
    processes.removeWhere((process) => process.name == processName);

    // Free the blocks allocated to this process
    for (MemoryBlock block in memoryBlocks) {
      if (block.process != null && block.process!.name == processName) {
        block.isFree = true; // Mark the block as free
        block.process = null; // Clear the reference to the process
      }
    }

    notifyListeners();
  }

  // Change the allocation algorithm and apply it to new processes
  void setAlgorithm(String algorithm) {
    selectedAlgorithm = algorithm;
    notifyListeners();
  }

  // Reset memory and clear all processes and allocations
  void resetMemory() {
    processes.clear();
    initializeMemory();
    notifyListeners();
  }
}
