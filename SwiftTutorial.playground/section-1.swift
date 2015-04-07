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


