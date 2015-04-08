// Playground - noun: a place where people can play
/*
// Define constants
let tutorialTeam: Int = 60
let editorialTeam = 17

var totalTeam = tutorialTeam + editorialTeam

let priceInferred = 19.99
let priceExplicit: Double = 19.99

let onSaleInferred = true
let onSaleExplicit: Bool = false

let nameInferred = "Whoopie Cushion"
let nameExplicit: String = "Whoopie Cushion"

if onSaleInferred {
    println("\(nameInferred) on sale for \(priceInferred)!")
} else {
    println("\(nameInferred) at regular price: \(priceInferred)!")
}
*/

/*
// 1. Create a class
class TipCalculator {
    // 2
    let total: Double
    let taxPct: Double
    let subtotal: Double
    
    // 3. Create initializer
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
        
        // compiler automatically infers self on subtotal
        subtotal = total / (taxPct + 1)
    }
    
    // 4. Declare a method.  Here we must be explicit about the types.
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    
    // 5. Declare a new method to print out tips.
    func printPossibleTips() {
//        println("15%: \(calcTipWithTipPct(0.15))")
//        println("18%: \(calcTipWithTipPct(0.18))")
//        println("20%: \(calcTipWithTipPct(0.20))")
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        for possibleTip in possibleTipsInferred {
            println("\(possibleTip*100)%: \(calcTipWithTipPct(possibleTip))")
        }
    }
    
    // Use a dictionary
    func returnPossibleTips() ->[Int: Double] {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        // Create an empty dictionary
        var retval = [Int: Double]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            
            // Set an item in the dictionary
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
    
}

// 6. Create an instance of our TipCalculator
let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
//tipCalc.printPossibleTips()
tipCalc.returnPossibleTips()
*/

// Tuples..
let tipAndTotal = (4.00, 25.19)
// Access elements of a tuple
tipAndTotal.0
tipAndTotal.1

// Named tuples..
let tipAndTotalNamed = (tipAmt:4.00, total:25.19)
tipAndTotalNamed.tipAmt
tipAndTotalNamed.total

// Explicit syntax..
let tipTotalExplict:(tipAmt:Double, total:Double) = (4.00, 25.19)

let total = 21.19
let taxPct = 0.06
let subtotal = total / (taxPct + 1)

func calcTipWithTipPct(tipPct:Double) -> (tipAmt:Double, total:Double) {
    let tipAmt = subtotal * tipPct
    let finalTotal = total + tipAmt
    return (tipAmt, finalTotal)
}

calcTipWithTipPct(0.20)

class TipCalculatorModel {
    
    var total: Double
    var taxPct: Double
    // Set subtotal as a computed property.
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> (tipAmt:Double, total:Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips() -> [Int: (tipAmt:Double, total:Double)] {
        
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        var retval = Dictionary<Int, (tipAmt:Double, total:Double)>()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}

// A protocol is a list of methods that specify a “contract” or “interface”.

// Create a protocol
protocol Speaker {
    func Speak()
}

// Create classes which conform to the Speaker protocol.
class Vicki: Speaker {
    func Speak() {
        println("Hello, I am Vicki")
    }
}

class Ray: Speaker {
    func Speak() {
        println("Yo, I am Ray!")
    }
}

class Animal {
}
// Create class Dog which inherits from class Animal and implements protocol Speaker.
// You can only inherit from one class in Swift, but can conform to any number of protocols.
class Dog: Animal, Speaker {
    func Speak() {
        println("Woof!")
    }
}

// Protocol with optional methods
@objc protocol Speaker2 {
    func Speak()
    optional func TellJoke()
}

class Vicki2: Speaker2 {
    func Speak() {
        println("Hello, I am Vicki2")
    }
    func TellJoke() {
        println("Q: What did Sushi A say to Sushi B?")  // Wasabi!
    }
}

class Ray2: Speaker2 {
    func Speak() {
        println("Yo, I am Ray!")
    }
    func TellJoke() {
        println("Q: Whats the object-oriented way to become wealthy?") // Inheritance
    }
    func WriteTutorial() {
        println("I'm on it!")
    }
}

class Dog2: Speaker2 {
    func Speak() {
        println("Woof!")
    }
}

var speaker:Speaker2
speaker = Ray2()
speaker.Speak()
(speaker as Ray2).WriteTutorial()
speaker = Vicki2()
speaker.Speak()
// Check if the TellJoke method exists using optional chaining.
// If you put a ? after the method name, it will check if it exists before calling it.
speaker.TellJoke?()
speaker = Dog2()
speaker.TellJoke?()

protocol DateSimulatorDelegate {
    func dateSimulatorDidStart(sim:DateSimulator, a:Speaker2, b:Speaker2)
    func dateSimulatorDidEnd(sim:DateSimulator, a: Speaker2, b:Speaker2)
}

class LoggingDateSimulator:DateSimulatorDelegate {
    func dateSimulatorDidStart(sim:DateSimulator, a:Speaker2, b:Speaker2) {
        println("Date started!")
    }
    func dateSimulatorDidEnd(sim:DateSimulator, a: Speaker2, b: Speaker2)  {
        println("Date ended!")
    }
}


class DateSimulator {
    let a:Speaker2
    let b:Speaker2
    
    // create optional delegate
    var delegate:DateSimulatorDelegate?
    
    init(a:Speaker2, b:Speaker2) {
        self.a = a
        self.b = b
    }
    
    func simulate() {
        delegate?.dateSimulatorDidStart(self, a:a, b:b)
        println("Off to dinner...")
        a.Speak()
        b.Speak()
        println("Walking back home...")
        a.TellJoke?()
        b.TellJoke?()
        delegate?.dateSimulatorDidEnd(self, a:a, b:b)
    }
}

let sim = DateSimulator(a: Vicki2(), b: Ray2())
sim.simulate()



