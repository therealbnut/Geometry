# Geometry

## Points

public struct Point2<Scalar: BinaryFloatingPoint>: Equatable

public var x: Scalar
public var y: Scalar
public init(x: Scalar, y: Scalar)

Point2(_ vector: Vector)

public func distance(to that: Point2) -> Scalar

## Vectors

public var dx: Scalar
public var dy: Scalar

public init(dx: Scalar, dy: Scalar)

public static var left: Vector2
public static var right: Vector2
public static var up: Vector2
public static var down: Vector2

public var lengthSquared: Scalar

public static func -(lhs: Point2, rhs: Point2) -> Vector
public static func +(lhs: Point2, rhs: Vector) -> Point2

public static func +=(lhs: inout Point2, rhs: Vector)
public static func -(lhs: Point2, rhs: Vector) -> Point2
public static func -=(lhs: inout Point2, rhs: Vector)

public static func +(lhs: Vector2, rhs: Vector2) -> Vector2
public static func +=(lhs: inout Vector2, rhs: Vector2)

public static func -(lhs: Vector2, rhs: Vector2) -> Vector2
public static func -=(lhs: inout Vector2, rhs: Vector2)

public static func *(lhs: Vector2, rhs: Scalar) -> Vector2
public static func *=(lhs: inout Vector2, rhs: Scalar)

public Vector2(Point2)
public Vector2(Angle)
public Point(Vector2)
public Angle(Vector2)

public mutating func rotate(by angle: Angle<Scalar>)
public func rotated(by angle: Angle<Scalar>) -> Vector2

public static prefix func -(that: Vector2) -> Vector2

public static func /(lhs: Vector2, rhs: Scalar) -> Vector2
public static func /=(lhs: inout Vector2, rhs: Scalar)

public var length: Scalar
public var perpendicular: Vector2

public mutating func normalize()
public func normalized() -> Vector2

public func angle(to that: Vector2) -> Angle<Scalar>

public func dot<T>(_ lhs: Vector2<T>, _ rhs: Vector2<T>) -> T

## Angles

public Angle(radians: Scalar)
public Angle(degrees: Scalar)

extension Angle: ExpressibleByFloatLiteral

public init(_ vector: Vector2<Scalar>)

public static func +(lhs: Angle, rhs: Angle) -> Angle
public static func +=(lhs: inout Angle, rhs: Angle)

public static func -(lhs: Angle, rhs: Angle) -> Angle
public static func -=(lhs: inout Angle, rhs: Angle)

public static func *(lhs: Angle, rhs: Scalar) -> Angle
public static func *=(lhs: inout Angle, rhs: Scalar)

public static prefix func -(angle: Angle) -> Angle

public var radians: Scalar
public var degrees: Scalar

public func cos<Scalar: BinaryFloatingPoint>(_ angle: Angle<Scalar>) -> Scalar
public func sin<Scalar: BinaryFloatingPoint>(_ angle: Angle<Scalar>) -> Scalar
