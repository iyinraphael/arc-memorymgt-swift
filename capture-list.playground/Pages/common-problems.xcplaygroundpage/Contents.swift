//: [Previous](@previous)

// MARK: - Strong reference cycles

/**
    When thing A owns thing B, and thing B owns thing A, you have what’s called a strong reference cycle, or often just a retain cycle.
 */
class House {
    var ownerDetails: (() -> Void)?
    
    func printDetails() {
        print("This a great house.")
    }
    
    deinit {
        print("I'm being demolished!")
    }
}

class Owner {
    var houseDetails: (() -> Void)?
    
    func printDetails() {
        print("I own a house.")
    }
    
    deinit {
        print("He's dying!")
    }
}

// Example 1
print("Creating a house and an owner")

do {
    let _ = House()
    let _ = Owner()
}

print("Done!")

// Example 2: create a strong reference cycle
print("Creating a house and a owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done!")

// Example 3: to fix this we need to create a new closure and use weak capturing for one or both values
print("Creating a house and a onwer")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails()}
    owner.houseDetails = { [weak house] in house?.printDetails()}
}

print("Done!!")

/**
 It isn’t necessary to have both values weakly captured – all that matters is that at least one is, because it allows Swift to destroy them both when necessary.

 Now, in real project code it’s rare to find strong reference cycles that are so obvious, but that just means it’s all the more important to use weak capturing to avoid the problem entirely.
 */

// MARK: - Accidental strong references
//Swift won’t let you use implicit self inside closures, which helps reduce a common type of retain cycle.

// MARK: - Copeis of closures
var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

let logger2 = logger1
logger2()
logger1()
logger2()

/**
 When to use strong, when to use weak, when to use unowned
 Now that you understand how everything works, let’s try to summarize whether to use strong, weak, or unowned references:

 1. If you know for sure your captured value will never go away while the closure has any chance of being called, you can use unowned. This is really only for the handful of times when weak would cause annoyances to use, but even when you could use guard let inside the closure with a weakly captured variable.
 
 2. If you have a strong reference cycle situation – where thing A owns thing B and thing B owns thing A – then one of the two should use weak capturing. This should usually be whichever of the two will be destroyed first, so if view controller A presents view controller B, view controller B might hold a weak reference back to A.
 
 3. If there’s no chance of a strong reference cycle you can use strong capturing. For example, performing animation won’t cause self to be retained inside the animation closure, so you can use strong capturing.
 If you’re not sure which to use, start out with weak and change only if you need to.
 */
//: [Next](@next)
