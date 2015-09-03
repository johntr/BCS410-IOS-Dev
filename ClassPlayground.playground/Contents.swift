//: Playground - noun: a place where people can play

import UIKit

var x:Int = 10 //explicit type
var y = 20 //infered
let z = x + y //constant

class Collector {
    var hold: [Int]
    var totalSum: Int {
        return addAll()
    }

    func addAll()->Int {
        var total = 0
        
        for h in hold {
            total += h
        }
        return total
    }
    convenience init() {
        self.init(ArrayDefault: [10,2,4])
    }
    init(ArrayDefault p:[Int]) {
        hold = p
    }
}

class CollectorKid: Collector {
    func  multAll()->Int {
        var totalMult = 1
        for x in hold {
            totalMult *= x
        }
        return totalMult
    }
    func addToCollection(x: Int) {
        hold.append(x)
    }
}
var hold = [10,2,4]
var c: Collector = Collector(ArrayDefault: hold)
var ck = CollectorKid(ArrayDefault: hold)
println(c.addAll())
ck.addToCollection(100)
println(ck.multAll())

var opt: Int? = nil

if opt != nil {
    
}