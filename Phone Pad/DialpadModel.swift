
import Foundation


class DialpadModel {
    private let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]
    
    private let alt = ["", "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ", "", "+", ""]
    
    public func getNum() -> [String] {
        return numbers
    }
    
    public func getAlt() -> [String] {
        return alt
    }
}
