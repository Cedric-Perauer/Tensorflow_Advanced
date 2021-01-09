// exercises of the Tensorflow tutorial "Swift Tour" 
//
//  main.swift
//  Swift Coding
//
//  Created by Cedric Perauer on 08.01.21.
//dict

var dict = [Int:String]()
dict[0] = "name"

//optional
var name_opt:String? = nil
if let name = name_opt {
    print("Hello \(name)")
}
else {
    name_opt = "name is nil"
    print(name_opt)
}

//optional with default val
var default_string:String? = nil
var name:String = "Kamala Harris and Joe Biden"

print("Hi \(default_string ?? name)")

//functions
func greet(name: String, lunch: String) -> String {
    return "Hello \(name), todays lunch is \(lunch)."
}
print(greet(name: "Bob", lunch: "Sushi"))

//closures
var numbers = [20, 19, 7, 12]
let mappedNumbers = numbers.map({ (number: Int) -> Int in
    var result = number
    if number%2 != 0 {
        result = 0
     }
    return result
})
print(mappedNumbers)

//sort
let sortedNumbers = numbers.sorted { $1 > $0 }
print(sortedNumbers)

//Classes
class Shape {
    var numberOfSides = 0
    let name:String = "Shape"
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }

    func nameShape()->String {
     return "An Objet named \(name)."
     }
}

//Subclass
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

let pi = Double.pi

class Circle: NamedShape {
    var radius: Double


    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)

    }

    func area() -> Double {
        return radius * radius * pi
    }

    override func simpleDescription() -> String {
        return "A square with radius of \(self.radius)."
    }
}
let test = Circle(radius: 5.2, name: "my test circle")
print(test.area())
print(test.simpleDescription())

//enum
enum Suit {
    case spades, hearts, diamonds, clubs

    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
       }

    func color(name: String) -> String {

            if name == "spades" {
                return "green"
            }
            else {
                return "blue"
        }
        }
        }

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
let color = hearts.color(name: heartsDescription)
print("Color is \(color) ")


// Error Handling
print("-----------Errors-------------")
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}


func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.onFire
    }
    else if printerName == "out of Paper" {
        throw PrinterError.noToner
    }

    return "Job sent"
}


do {
    let printerResponse = try send(job: 1440, toPrinter: "out of Paper")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}
// use try
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")

//Defer executes after other in a func
print("------------Defer------------")
var carExists = false
let cars = ["Model 3", "Model S"]

func garageContains(_ food: String) -> Bool {
    carExists = true
    defer {
        carExists = false //executes at the end
    }

    let result = cars.contains(food)
    return result
}
print(garageContains("Model S"))
print(carExists)

//Generics
print("------------Generics------------")
// here where is used to specifiy requierements
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
print(anyCommonElements([1, 2, 3], [3]))



