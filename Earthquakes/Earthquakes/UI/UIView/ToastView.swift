//
//  ToastView.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 8/5/22.
//

import UIKit

class ToastView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI(){
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        textColor = .white
        font = UIFont.systemFont(ofSize: .subdetailFont)
        textAlignment = .center
        alpha = 1.0
        layer.cornerRadius = 10
        clipsToBounds  =  true
        isScrollEnabled  = false
        isEditable = false
        textContainerInset = UIEdgeInsets(top: .sepearateSpace, left: .sepearateSpace, bottom: .sepearateSpace, right: .sepearateSpace)
    }
    
    func showOn(_ view : UIView?, message: String) {
        guard let view = view else {
            return
        }
        text = message
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.constrainToLayoutMarginsGuide(edges: .centerX)
        self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: .sepearateSpaceBefore).isActive = true
        self.leadingAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        UIView.animate(withDuration: 0.4, delay: 5, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: {(isCompleted) in
            self.removeFromSuperview()
        })
    }

}
