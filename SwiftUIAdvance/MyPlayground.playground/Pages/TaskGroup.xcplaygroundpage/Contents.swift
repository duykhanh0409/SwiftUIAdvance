//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
import UIKit
import Foundation


//`getCountries`: returns a list of country names
//- `getPopulation`: returns the population of a country
//
//The task is to asynchronously create a dictionary where:
//
//- `[String: Int]` keys: country name, values: population

//prepare 2 function getCountries and get population

print("hello world")

let mockCountries: [String] = ["France", "Germany", "Italy"]


func getCountries() async -> [String] {
    return mockCountries
}

func getPopulation(country:String) async -> Int {
    switch country {
    case "France": return 600000
    case "Germany": return 1200000
    case "Italy": return 60000
    default: return 0
    }
}

actor ResultCollector {
    private var data: [String: Int] = [:]
    
    func set(_ country: String, population: Int) {
        data[country] = population
    }
    
    func get() -> [String: Int] {
        return data
    }
}




func createCountryPopulationDict() async -> [String: Int] {
    let countries = await getCountries()
    let serialQueue = DispatchQueue(label: "com.example.serialQueue")
    let collector = ResultCollector()
    // using actor there to prevent potential race condition
    // this case we intentionaly make the type is Void.self
    await withTaskGroup(of: Void.self) { group in
        for country in countries {
            group.addTask {
                let population = await getPopulation(country: country)
                await collector.set(country, population: population)
            }
        }
        
    }
    
    return await collector.get()
    
}


Task {
    let dictionary = await createCountryPopulationDict()
    print(dictionary)
}


let MOD = Int(1e9 + 7)

func countValidNetworks(server_nodes: Int, server_from: [Int], server_to: [Int]) -> Int {
    var adj = Array(repeating: [Int](), count: server_nodes)
    for i in 0..<server_from.count {
        let u = server_from[i]
        let v = server_to[i]
        adj[u].append(v)
        adj[v].append(u)
    }
    
    var color = Array(repeating: -1, count: server_nodes)
    var res = 1
    
    for node in 0..<server_nodes {
        if color[node] != -1 { continue }
        
        var queue = [node]
        color[node] = 0
        
        var count0 = 1  // số node màu 0
        var count1 = 0  // số node màu 1
        var isOk = true
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            for neighbor in adj[cur] {
                if color[neighbor] == -1 {
                    color[neighbor] = 1 - color[cur]
                    if color[neighbor] == 0 {
                        count0 += 1
                    } else {
                        count1 += 1
                    }
                    queue.append(neighbor)
                } else if color[neighbor] == color[cur] {
                    isOk = false
                }
            }
        }
        
        if !isOk {
            return 0
        }
        
        // Chỉ node màu 0 mới có 2 lựa chọn: 1 hoặc 3
        // => Tổng số cách cho component này = 2^count0
        let ways = powmod(2, count0)
        res = (res * ways) % MOD
    }
    
    return res
}

func powmod(_ base: Int, _ exp: Int) -> Int {
    var ans = 1
    var b = base
    var e = exp
    while e > 0 {
        if e % 2 == 1 {
            ans = (ans * b) % MOD
        }
        b = (b * b) % MOD
        e /= 2
    }
    return ans
}
