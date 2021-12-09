import Cocoa
import Foundation

//Insertion Sort
extension Array where Element: Comparable {

func insertionSort() -> Array<Element> {

    guard self.count > 1 else {
        return self
    }
    
    var array = self
    for i in 0..<array.count {
        let key = array[i]
        var j = i
        
        while j > -1 {
            if key < array[j] {
                array.remove(at: j + 1)
                array.insert(key, at: j)
            }
            j -= 1
        }
    }
    
    return array
   }
}

//Quick Sort
extension Array where Element: Comparable{
    
    mutating func quickSort() -> Array<Element> {
        func qSort(start startIndex: Int, _ pivot: Int) {
            
            if (startIndex < pivot) {
                let iPivot = qPartition(start: startIndex, pivot)
                qSort(start: startIndex, iPivot - 1)
                qSort(start: iPivot + 1, pivot)
            }
        }
        qSort(start: 0, self.endIndex - 1)
        return self
    }

    private mutating func qPartition(start startIndex: Int, _ pivot: Int) -> Int {
        var wallIndex: Int = startIndex
        for currentIndex in wallIndex..<pivot {
            
        if self[currentIndex] <= self[pivot] {
            if wallIndex != currentIndex {
                self.swapAt(currentIndex, wallIndex)
               }
            wallIndex += 1
            }
       }
        if wallIndex != pivot {
            self.swapAt(wallIndex, pivot)
        }
        return wallIndex
    }
}

var test = [2, 3, 10,5, 500, 45, 20]
test.quickSort()
test.insertionSort()


