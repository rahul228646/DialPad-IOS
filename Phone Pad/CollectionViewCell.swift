//
//  CollectionViewCell.swift
//  Phone Pad
//
//  Created by rahul kaushik on 30/01/23.
//

import UIKit

protocol CollectionViewCellDelegate : AnyObject {
    
    func collectionViewTableViewCellDidTapCell(_ cell : CollectionViewCell, number : String?)
}

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GridCollectionViewCell"
    
    weak var delegate: (CollectionViewCellDelegate)?
    
    let numberButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    
    let dialpadLabelNumber : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let dialpadLabelAlpha : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "A"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(numberButton)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.numberButton.addGestureRecognizer(longPress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        numberButton.addSubview(dialpadLabelNumber)
        numberButton.addSubview(dialpadLabelAlpha)
        
        configLayout()
    }
    
    func configLayout() {
        NSLayoutConstraint.activate([
            numberButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dialpadLabelNumber.centerXAnchor.constraint(equalTo: numberButton.centerXAnchor),
            dialpadLabelNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height*0.3),
            dialpadLabelAlpha.centerXAnchor.constraint(equalTo: numberButton.centerXAnchor),
            dialpadLabelAlpha.topAnchor.constraint(equalTo: dialpadLabelNumber.bottomAnchor, constant: 5)
        ])
    }
    
    @objc func onClick() {
        self.delegate?.collectionViewTableViewCellDidTapCell(self, number: dialpadLabelNumber.text)
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.ended {
            self.delegate?.collectionViewTableViewCellDidTapCell(self, number: dialpadLabelAlpha.text)
            }
    }

}
