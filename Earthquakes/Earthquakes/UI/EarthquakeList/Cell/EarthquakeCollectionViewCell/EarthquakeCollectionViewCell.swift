//
//  EarthquakeCollectionViewCell.swift
//  Earthquakes
//
//  Created by Mingjun Lei on 7/30/22.
//

import UIKit
class EarthquakeCollectionViewCell: UICollectionViewCell, CellIdentifierProvider {
    
    var dataModel: EarthquakeCellDataModel? {
        didSet {
            let vm = dataModel?.viewModel
            imageView.image = UIImage.init(named: vm?.imageName ?? "ImageNotFound")
            titleLabel.text = vm?.title
            subtitleLabel.text = vm?.subtile
            detailTextView.text = vm?.detail
            boottomLeftLabel.text = vm?.leftBottom
            boottomRightButton.setTitle(vm?.rightButtonTitle, for: .normal)
            boottomRightButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }

    lazy var imageView: UIImageView = {
        let image = UIImage.init(named: "ImageNotFound")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = .imageCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.constrainTo(.height, c: .profileImageHeight)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 2.0/3.0).isActive = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .titleFont)
        label.text = Array.init(repeating: "Title ", count: Int.random(in: 0..<10)).joined(separator: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .subtitleFont)
        label.text = Array.init(repeating: "Subtitle Label ", count: Int.random(in: 0..<20)).joined(separator: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.label
        textView.font = UIFont.systemFont(ofSize: .detailFont)
        textView.text = Array.init(repeating: "Detail TextView ", count: Int.random(in: 0..<50)).joined(separator: "")
        textView.textAlignment = .left
        textView.dataDetectorTypes = .link
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled  = false
        return textView
    }()
    
    lazy var boottomLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: .subdetailFont)
        label.textColor = UIColor.darkGray
        label.text = Array.init(repeating: "Left ", count: Int.random(in: 1..<10)).joined(separator: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var boottomRightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = .buttonCornerRadius
        button.setTitle("Right Button", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: .subdetailFont)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var topSeparatorView: UIView = buildSeparatorLine()

    lazy var bottomSeparatorView: UIView = buildSeparatorLine()
    
    lazy var bottomLabelSeparatorView: UIView = buildSeparatorLine()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.layer.borderWidth = .sepearateLineSpace
        addViews()
    }
    
    override func prepareForReuse() {
        dataModel = nil
    }

    @objc
    func didTapButton() {
        dataModel?.actionModel.rightButtonAction()
    }
}

extension EarthquakeCollectionViewCell {
    
    /// layout the UI with constriants, setup based on LayoutMarginsGuide
    private func addViews() {
        let views = [titleLabel, subtitleLabel, topSeparatorView, imageView, detailTextView, bottomSeparatorView]
        views.enumerated().forEach { (index, view) in
            contentView.addSubview(view)
            if view == imageView {
                imageView.constrainToLayoutMarginsGuide(edges: .centerX)
            }else{
                view.constrainToLayoutMarginsGuide(edges: .leading, .trailing)
            }
            
            if index == views.startIndex {
                view.constrainToLayoutMarginsGuide(edges: .top)
            } else {
                view.topAnchor.constraint(equalTo: views[index - 1].bottomAnchor, constant: .sepearateSpace).isActive = true
            }
        }
        topSeparatorView.constrainTo(.height, c: .sepearateLineSpace)
        bottomSeparatorView.constrainTo(.height, c: .sepearateLineSpace)
        
        contentView.addSubview(boottomLeftLabel)
        boottomLeftLabel.constrainToLayoutMarginsGuide(edges: .leading)
        boottomLeftLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor, constant: .sepearateSpaceBefore).isActive = true
        boottomLeftLabel.topAnchor.constraint(equalTo: bottomSeparatorView.bottomAnchor, constant: .sepearateSpace).isActive = true

        
        contentView.addSubview(boottomRightButton)
        boottomRightButton.constrainToLayoutMarginsGuide(edges: .trailing)
        boottomRightButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor, constant: .sepearateSpaceAfter).isActive = true
        boottomRightButton.centerYAnchor.constraint(equalTo: boottomLeftLabel.centerYAnchor).isActive = translatesAutoresizingMaskIntoConstraints

        contentView.addSubview(bottomLabelSeparatorView)
        bottomLabelSeparatorView.constrainTo(.width, c: .sepearateLineSpace)
        bottomLabelSeparatorView.constrainToLayoutMarginsGuide(edges: .centerX, spacing: .sepearateSpaceBefore)
        bottomLabelSeparatorView.topAnchor.constraint(equalTo: bottomSeparatorView.bottomAnchor, constant: .sepearateSpace).isActive = true
        bottomLabelSeparatorView.bottomAnchor.constraint(equalTo: boottomLeftLabel.layoutMarginsGuide.bottomAnchor, constant: .sepearateSpace).isActive = true
    }
    
    private func buildSeparatorLine() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension EarthquakeCollectionViewCell: CalculateSelfHeight {
    
    func calculateHieght(width: CGFloat) -> CGFloat {
        var resultingHeight: CGFloat = 0
        let width = width - contentView.layoutMargins.left  - contentView.layoutMargins.right
        resultingHeight += .profileImageHeight + .sepearateSpace
        resultingHeight += titleLabel.calculateHieght(width: width) + .sepearateSpace
        resultingHeight += subtitleLabel.calculateHieght(width: width) + .sepearateSpace
        resultingHeight += .sepearateLineSpace + .sepearateSpace
        resultingHeight += detailTextView.calculateHieght(width: width) + .sepearateSpace
        resultingHeight += .sepearateLineSpace + .sepearateSpace
        resultingHeight += boottomLeftLabel.calculateHieght(width: width) + .sepearateSpace
        resultingHeight += contentView.layoutMargins.top
        return resultingHeight
    }
}
