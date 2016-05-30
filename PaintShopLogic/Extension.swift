import Foundation
// an extention to String to change a string into an integer
public extension String {
    func toInt() -> Int {
        if let safeInt = Int(self) {
            return safeInt
        } else {
            return -1
        }
    }
}

