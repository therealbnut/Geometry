//
//  Point2.swift
//  Math
//
//  Created by Andrew Bennett on 19/11/18.
//

import Foundation

public struct Point2<Scalar: BinaryFloatingPoint>: Equatable {
    @usableFromInline
    internal var vector: Vector2<Scalar>

    @inlinable
    @_transparent
    public var x: Scalar {
        get { return vector.dx }
        set { vector.dx = newValue }
    }

    @inlinable
    @_transparent
    public var y: Scalar {
        get { return vector.dy }
        set { vector.dy = newValue }
    }

    @inlinable
    @_transparent
    public init(x: Scalar, y: Scalar) {
        self.vector = Vector2(dx: x, dy: y)
    }
}

extension Point2 {
    public typealias Vector = Vector2<Scalar>

    @inlinable
    @_transparent
    public init(_ vector: Vector) {
        self.vector = vector
    }
}

extension Point2 {

    @inlinable
    @_transparent
    public static func -(lhs: Point2, rhs: Point2) -> Vector {
        return lhs.vector - rhs.vector
    }

    @inlinable
    @_transparent
    public static func +(lhs: Point2, rhs: Vector) -> Point2 {
        return Point2(lhs.vector + rhs)
    }
    @inlinable
    @_transparent
    public static func +=(lhs: inout Point2, rhs: Vector) {
        lhs.vector += rhs
    }

    @inlinable
    @_transparent
    public static func -(lhs: Point2, rhs: Vector) -> Point2 {
        return Point2(lhs.vector - rhs)
    }
    @inlinable
    @_transparent
    public static func -=(lhs: inout Point2, rhs: Vector) {
        lhs.vector -= rhs
    }

}

extension Point2 {

    @inlinable
    public func distance(to that: Point2) -> Scalar {
        return (self - that).length
    }

}

extension Point2: CustomStringConvertible {

    public var description: String {
        return "(\(x), \(y))"
    }

}
