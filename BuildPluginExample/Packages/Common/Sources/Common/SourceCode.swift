// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class Foo {

  private let a = 10
  private let b = 12
  private let multiplier: Multiplier

  public init(multiplier: Multiplier) {
    self.multiplier = multiplier
  }

  public func calculate() -> Int {
    print(Bundle.module.path(forResource: "1MBImage", ofType: "jpg")!)
    return (a * multiplier.multiplier - b) * multiplier.multiplier
  }
}

public protocol Multiplier {
  var multiplier: Int { get }
}
