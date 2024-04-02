//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif


public protocol ConstraintDSL {

    var target: AnyObject? { get }
    var layoutConstraintItem: LayoutConstraintItem? { get }

    func setLabel(_ value: String?)
    func label() -> String?

}
extension ConstraintDSL {

    public func setLabel(_ value: String?) {
        objc_setAssociatedObject(self.target as Any, &labelKey, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    public func label() -> String? {
        return objc_getAssociatedObject(self.target as Any, &labelKey) as? String
    }

}
private var labelKey: UInt8 = 0


public protocol ConstraintBasicAttributesDSL : ConstraintDSL {
}
extension ConstraintBasicAttributesDSL {

    // MARK: Basics

    public var left: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.left)
    }

    public var top: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.top)
    }

    public var right: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.right)
    }

    public var bottom: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.bottom)
    }

    public var leading: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.leading)
    }

    public var trailing: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.trailing)
    }

    public var width: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.width)
    }

    public var height: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.height)
    }

    public var centerX: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.centerX)
    }

    public var centerY: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.centerY)
    }

    public var edges: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.edges)
    }

    public var directionalEdges: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.directionalEdges)
    }

    public var size: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.size)
    }

    public var center: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.center)
    }

}

public protocol ConstraintAttributesDSL : ConstraintBasicAttributesDSL {
}
extension ConstraintAttributesDSL {

    // MARK: Baselines

    @available(*, deprecated, message:"Use .lastBaseline instead")
    public var baseline: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.lastBaseline)
    }

    @available(iOS 8.0, OSX 10.11, *)
    public var lastBaseline: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.lastBaseline)
    }

    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.firstBaseline)
    }

    // MARK: Margins

    @available(iOS 8.0, *)
    public var leftMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.leftMargin)
    }

    @available(iOS 8.0, *)
    public var topMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.topMargin)
    }

    @available(iOS 8.0, *)
    public var rightMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.rightMargin)
    }

    @available(iOS 8.0, *)
    public var bottomMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.bottomMargin)
    }

    @available(iOS 8.0, *)
    public var leadingMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.leadingMargin)
    }

    @available(iOS 8.0, *)
    public var trailingMargin: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.trailingMargin)
    }

    @available(iOS 8.0, *)
    public var centerXWithinMargins: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.centerXWithinMargins)
    }

    @available(iOS 8.0, *)
    public var centerYWithinMargins: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.centerYWithinMargins)
    }

    @available(iOS 8.0, *)
    public var margins: ConstraintItem {
        makeConstraint(for: self, attributes:  ConstraintAttributes.margins)
    }

    @available(iOS 8.0, *)
    public var directionalMargins: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.directionalMargins)
    }

    @available(iOS 8.0, *)
    public var centerWithinMargins: ConstraintItem {
        makeConstraint(for: self, attributes: ConstraintAttributes.centerWithinMargins)
    }

}

private func makeConstraint(for dsl: ConstraintDSL, attributes: ConstraintAttributes) -> ConstraintItem {
    if let item = dsl.layoutConstraintItem {
        return ConstraintItem(layoutConstraintItem: item, attributes: attributes)
    } else {
        return ConstraintItem(target: dsl.target, attributes: attributes)
    }
}
