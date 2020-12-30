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

//: [Next](@next)
