//
//  ChipCollectionViewCell.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/08/21.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    static let indentifier = "chipcollectionviewcell"
    
    let contentContainer = UIView()
    let titleLabel = UILabel()
    
    
    var title: String? {
      didSet {
        configure()
      }
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

extension ChipCollectionViewCell {
    func configure(){
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(contentContainer)
        
        titleLabel.text = "WOY"
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowRadius = 3.0
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        titleLabel.center.x = contentContainer.center.x
        titleLabel.center.y = contentContainer.center.y
        contentContainer.addSubview(titleLabel)
        contentView.addSubview(titleLabel)
        
        
        configureConstraint()
    }
    
    private func configureConstraint(){
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor)
        
        ])
    }
}
