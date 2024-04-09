import Foundation

// custom prefix func implementation
prefix operator √
prefix func √(num: Double) -> Double {
	return sqrt(num)
}

√9


// custom infix func implementation
infix operator ∞
func ∞(lhs: Int, rhs: Int) -> Int {
	return (lhs + rhs) * 10000
}

4 ∞ 4
