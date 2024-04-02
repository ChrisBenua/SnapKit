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

#if canImport(UIKit)
    import UIKit
#else
    import AppKit
#endif


public final class ConstraintItem {

    internal weak var target: AnyObject?
    internal let attributes: ConstraintAttributes
    internal weak var _layoutConstraintItem: LayoutConstraintItem?

    internal init(target: AnyObject?, attributes: ConstraintAttributes) {
        self.target = target
        self._layoutConstraintItem = nil
        self.attributes = attributes
    }

    internal init(layoutConstraintItem: LayoutConstraintItem?, attributes: ConstraintAttributes) {
        self._layoutConstraintItem = layoutConstraintItem
        self.target = layoutConstraintItem
        self.attributes = attributes
    }

    internal var layoutConstraintItem: LayoutConstraintItem? {
        _layoutConstraintItem
    }
}

public func ==(lhs: ConstraintItem, rhs: ConstraintItem) -> Bool {
    // pointer equality
    guard lhs !== rhs else {
        return true
    }

    // must both have valid targets and identical attributes
    guard let target1 = lhs.valueToCompare,
          let target2 = rhs.valueToCompare,
          target1 === target2 && lhs.attributes == rhs.attributes else {
            return false
    }

    return true
}

private extension ConstraintItem {
    var valueToCompare: AnyObject? {
        if let value = _layoutConstraintItem {
            return value
        } else if let target {
            return target
        } else {
            return nil
        }
    }
}
