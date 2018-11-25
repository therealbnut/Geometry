//
//  Angle.swift
//  Math
//
//  Created by Andrew Bennett on 19/11/18.
//

import Foundation

public struct Angle<Scalar: BinaryFloatingPoint>: Equatable {
    @usableFromInline
    internal var vector: Vector2<Scalar>

    @usableFromInline
    internal init(vector: Vector2<Scalar>) {
        self.vector = vector
    }

    @inlinable
    public init(radians: Scalar) {
        let dx = Scalar(cos(Double(radians)))
        let dy = Scalar(sin(Double(radians)))
        self.init(vector: Vector2(dx: dx, dy: dy))
    }

    @inlinable
    public init(degrees: Scalar) {
        self.init(radians: degrees * (.pi / 180))
    }
}

extension Angle: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Scalar.FloatLiteralType

    public init(floatLiteral value: Scalar.FloatLiteralType) {
        self.init(degrees: Scalar(floatLiteral: value))
    }
}

extension Angle {

    @inlinable
    public init(_ vector: Vector2<Scalar>) {
        self.init(vector: vector.normalized())
    }

    @inlinable
    @_transparent
    public static func +(lhs: Angle, rhs: Angle) -> Angle {
        var angle = lhs
        angle += rhs
        return angle
    }

    @inlinable
    @_transparent
    public static func +=(lhs: inout Angle, rhs: Angle) {
        lhs.vector.rotate(by: rhs)
        lhs.vector.normalize()
    }

    @inlinable
    @_transparent
    public static func -(lhs: Angle, rhs: Angle) -> Angle {
        var angle = lhs
        angle -= rhs
        return angle
    }

    @inlinable
    @_transparent
    public static func -=(lhs: inout Angle, rhs: Angle) {
        lhs.vector.rotate(by: -rhs)
        lhs.vector.normalize()
    }

    @inlinable
    @_transparent
    public static func *(lhs: Angle, rhs: Scalar) -> Angle {
        var angle = lhs
        angle *= rhs
        return angle
    }

    @inlinable
    @_transparent
    public static func *=(lhs: inout Angle, rhs: Scalar) {
        // TODO: This combines multiple iterative solutions,
        // they could probably be combined for more speed:
        // e ^ (m i atan2(y,x)) == (x + i y) ^ rhs
        lhs = Angle(radians: lhs.radians * rhs)
    }

    @inlinable
    @_transparent
    public static prefix func -(angle: Angle) -> Angle {
        return Angle(vector: Vector2(dx:  angle.vector.dx,
                                     dy: -angle.vector.dy))
    }

    @inlinable
    public var radians: Scalar {
        return Scalar(atan2(Double(vector.dy),
                            Double(vector.dx)))
    }

    @inlinable
    public var degrees: Scalar {
        return radians * (180.0 / .pi)
    }

}

extension Angle: CustomStringConvertible {

    public var description: String {
        return "\(degrees)º"
    }

}

public func cos<Scalar: BinaryFloatingPoint>(_ angle: Angle<Scalar>) -> Scalar {
    return angle.vector.dx
}

public func sin<Scalar: BinaryFloatingPoint>(_ angle: Angle<Scalar>) -> Scalar {
    return angle.vector.dy
}
