//
//  Vector2.swift
//  Math
//
//  Created by Andrew Bennett on 19/11/18.
//

import Foundation

public struct Vector2<Scalar: BinaryFloatingPoint>: Equatable {
    public var dx: Scalar
    public var dy: Scalar

    @inlinable
    @_transparent
    public init(dx: Scalar, dy: Scalar) {
        self.dx = dx
        self.dy = dy
    }
}

extension Vector2 {

    public static var left: Vector2 {
        return Vector2(dx: -1, dy: 0)
    }
    public static var right: Vector2 {
        return Vector2(dx: 1, dy: 0)
    }
    public static var up: Vector2 {
        return Vector2(dx: 0, dy: 1)
    }
    public static var down: Vector2 {
        return Vector2(dx: 0, dy: -1)
    }

    @inlinable
    @_transparent
    public var lengthSquared: Scalar {
        return dot(self, self)
    }

}

extension Vector2 {

    @inlinable
    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(dx: lhs.dx + rhs.dx,
                       dy: lhs.dy + rhs.dy)
    }
    @inlinable
    public static func +=(lhs: inout Vector2, rhs: Vector2) {
        lhs.dx += rhs.dx
        lhs.dy += rhs.dy
    }

    @inlinable
    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(dx: lhs.dx - rhs.dx,
                       dy: lhs.dy - rhs.dy)
    }
    @inlinable
    public static func -=(lhs: inout Vector2, rhs: Vector2) {
        lhs.dx -= rhs.dx
        lhs.dy -= rhs.dy
    }

    @inlinable
    public static func *(lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(dx: lhs.dx * rhs,
                       dy: lhs.dy * rhs)
    }
    @inlinable
    public static func *=(lhs: inout Vector2, rhs: Scalar) {
        lhs.dx *= rhs
        lhs.dy *= rhs
    }
}

extension Vector2 {
    public typealias Point = Point2<Scalar>

    @inlinable
    @_transparent
    public init(_ point: Point) {
        self = point.vector
    }

    @inlinable
    public init(_ angle: Angle<Scalar>) {
        self = angle.vector
    }

}

extension Vector2 {

    @inlinable
    public mutating func rotate(by angle: Angle<Scalar>) {
        self = self.rotated(by: angle)
    }

    @inlinable
    public func rotated(by angle: Angle<Scalar>) -> Vector2 {
        let that = angle.vector
        return Vector2(dx: dx * that.dx - dy * that.dy,
                       dy: dy * that.dx + dx * that.dy)
    }

}

extension Vector2 {

    @inlinable
    public static prefix func -(that: Vector2) -> Vector2 {
        return Vector2(dx: -that.dx,
                       dy: -that.dy)
    }

    @inlinable
    public static func /(lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(dx: lhs.dx / rhs,
                       dy: lhs.dy / rhs)
    }
    @inlinable
    public static func /=(lhs: inout Vector2, rhs: Scalar) {
        lhs.dx /= rhs
        lhs.dy /= rhs
    }

    @inlinable
    public var length: Scalar {
        return sqrt(lengthSquared)
    }

    @inlinable
    public var perpendicular: Vector2 {
        return Vector2(dx: -dy, dy: dx)
    }

    @inlinable
    public mutating func normalize() {
        let qmagsq = self.lengthSquared
        if abs(1 - qmagsq) < 2.107342e-08  {
            self *= Scalar(2) / (Scalar(1) + qmagsq)
        }
        else {
            self *= Scalar(1) / sqrt(qmagsq)
        }
    }

    @inlinable
    public func normalized() -> Vector2 {
        var output = self
        output.normalize()
        return output
    }

    @inlinable
    public func angle(to that: Vector2) -> Angle<Scalar> {
        return Angle(Vector2(dx: dot(that, self),
                             dy: dot(that, self.perpendicular)))
    }
}

extension Vector2: CustomStringConvertible {

    public var description: String {
        return "<\(dx), \(dy)>"
    }

}

@inlinable
public func dot<T>(_ lhs: Vector2<T>, _ rhs: Vector2<T>) -> T {
    return lhs.dx * rhs.dx + lhs.dy * rhs.dy
}
