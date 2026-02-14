//
//  ProductCell.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(accessoryImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            nameLabel.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -8),
            
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.title
    }
}
