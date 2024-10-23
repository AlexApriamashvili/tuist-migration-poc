
import Foundation
import Common

public class Bar {

  private let a = 23
  private let b = 15
  private let multiplier: Multiplier

  public init(multiplier: Multiplier) {
    self.multiplier = multiplier
  }

  public func calculate() -> Int { (a * multiplier.multiplier - b) * multiplier.multiplier }
}
