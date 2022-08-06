//
//  CalculateSelfHeight.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/2/22.
//

import UIKit
/// Calculate the view height base on its content and target width
protocol CalculateSelfHeight {
    func calculateHieght(width: CGFloat) -> CGFloat
}

extension UIButton: CalculateSelfHeight {
    func calculateHieght(width: CGFloat) -> CGFloat {
        return self.intrinsicContentSize.height
    }
}

extension UILabel: CalculateSelfHeight {
    func calculateHieght(width: CGFloat) -> CGFloat {
        let size = self.sizeThatFits(CGSize.init(width: width, height: .greatestFiniteMagnitude))
        return ceil(size.height)
    }
}

extension UITextView:  CalculateSelfHeight{
    func calculateHieght(width: CGFloat) -> CGFloat {
        let size = self.sizeThatFits(CGSize.init(width: width, height: .greatestFiniteMagnitude))
        return ceil(size.height)
    }
}
