//
//  CollectionViewCell.swift
//  SearchController
//
//  Created by qaisar.raza on 13/05/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reusueIdentifier = "\(CollectionViewCell.self)"
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()

    fileprivate lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    fileprivate lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    fileprivate lazy var checkImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    func configure(_ data: String) {
        textLabel.text = data
        imageView.image = UIImage(named: data)
    }
    
    func updateSelection() {
        if(isSelected) {
            self.checkImageView.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        } else {
            self.checkImageView.image = UIImage(named: "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        contentView.addSubview(stackView)
        contentView.addSubview(checkImageView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            checkImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
    }
    
}
