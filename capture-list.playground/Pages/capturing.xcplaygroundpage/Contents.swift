//: [Previous](@previous)

import Foundation

class Singer {
    
    func playSong(){
        print("Ko por Ke!")
    }
}

// MARK: - Strong capturing

// This is a function that returns a closure
func sing() -> () -> Void {
    let nairaMaley = Singer()
    
    // Closure which captures nairaMalet as a strong reference
    let singing = {
        nairaMaley.playSong()
        return
    }
    
    return singing
}


let singFunction = sing()
singFunction()

// MARK: - Weak capturing

/**
 Swift lets us specify a capture list to determine how values used inside the closure should be captured. The most common alternative to strong capturing is called weak capturing, and it changes two things:

 1. Weakly captured values aren’t kept alive by the closure, so they might be destroyed and be set to nil.
 2. As a result of 1, weakly captured values are always optional in Swift. This stops you assuming they are present when in fact they might not be.
 */

func singWeak() -> () -> Void {
    let zlatan = Singer()
    
    let shouting = { [weak zlatan] in
        zlatan?.playSong()
        return
    }
    
    return shouting
}

let singWeakFunction = singWeak()
singWeakFunction()


// MARK: - Unowned capturing

/**
 An alternative to weak is unowned, which behaves more like implicitly unwrapped optionals. Like weak capturing, unowned capturing allows values to become nil at any point in the future. However, you can work with them as if they are always going to be there – you don’t need to unwrap optionals.
 */

func singUnowned() -> () -> Void {
    let olamide = Singer()
    
    let rapping = { [unowned olamide ] in
        olamide.playSong()
        return
    }
    
    return rapping
}



//: [Next](@next)
