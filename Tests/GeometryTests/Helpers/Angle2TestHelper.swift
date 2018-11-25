import XCTest
@testable import Geometry

internal func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> Angle2<T>,
    _ expression2: @autoclosure () throws -> Angle2<T>,
    accuracy: T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) rethrows
{
    XCTAssertEqual(try expression1().degrees,
                   try expression2().degrees,
                   accuracy: accuracy,
                   message(),
                   file: file,
                   line: line)
}
