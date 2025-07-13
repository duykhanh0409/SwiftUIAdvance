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


//the task is determind minimum number of operation require to transfer array data into a palindrome
func getMinOperations(data: [Int]) -> Int {
    var parent = [Int: Int]()
    
    func find(_ x: Int) -> Int {
        if parent[x] == nil {
            parent[x] = x
        }
        if parent[x]! != x {
            parent[x] = find(parent[x]!)
        }
        return parent[x]!
    }
    
    func merge(_ a: Int, _ b: Int) {
        let rootA = find(a)
        let rootB = find(b)
        if rootA != rootB {
            parent[rootA] = rootB
        }
    }
    
    let n = data.count
    for i in 0..<n/2 {
        let left = data[i]
        let right = data[n - 1 - i]
        if left != right {
            merge(left, right)
        }
    }
    
    var groupSizes = [Int: Int]()
    for x in parent.keys {
        let root = find(x)
        groupSizes[root, default: 0] += 1
    }
    
    var operations = 0
    for size in groupSizes.values {
        operations += size - 1
    }
    
    return operations
}
let a = [1, 2, 3, 2, 1, 3]
print(getMinOperations(data: a))
