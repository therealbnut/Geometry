import XCTest
@testable import Geometry

internal func XCTAssertEqual<T>(
    _ expression1: @autoclosure () throws -> Vector2<T>,
    _ expression2: @autoclosure () throws -> Vector2<T>,
    accuracy: T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line) rethrows
    where T: FloatingPoint
{
    let value1 = try expression1()
    let value2 = try expression2()
    func combinedMessage(_ message: String, axis: String) -> String {
        return message.isEmpty
            ? "in the \(axis) axis"
            : "in the \(axis) axis, \(message)"
    }
    XCTAssertEqual(value1.dx, value2.dx, accuracy: accuracy,
                   combinedMessage(message(), axis: "x"),
                   file: file,
                   line: line)
    XCTAssertEqual(value1.dy, value2.dy, accuracy: accuracy,
                   combinedMessage(message(), axis: "y"),
                   file: file,
                   line: line)
}
