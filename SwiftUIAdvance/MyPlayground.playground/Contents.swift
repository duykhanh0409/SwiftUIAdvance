import UIKit

var greeting = "Hello, playground"



func getMaxSumPossibleSumOfTheNumberOfDistinceElementInEachSubArrayOfSizeK(arr: [Int]) -> Int {
    let n = arr.count
    var leftSet = Set<Int>(), rightSet = Set<Int>()
    var left = [Int](repeating: 0, count: n)
    var right = [Int](repeating: 0, count: n)
    
    for i in 0..<n {
        leftSet.insert(arr[i])
        left[i] = leftSet.count
    }
    
    for i in (0..<n).reversed() {
        rightSet.insert(arr[i])
        right[i] = rightSet.count
    }
    
    var maxSum = 0
    for i in 0..<n-1 {
        let sum = left[i] + right[i+1]
        maxSum = max(maxSum, sum)
    }
    
    return maxSum
}
