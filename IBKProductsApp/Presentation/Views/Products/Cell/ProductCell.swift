//
//  ProductCell.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGreen
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
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(accessoryImageView)
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            
            textStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            textStackView.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -8),
            
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        
        if let imageUrl = product.images.first, let url = URL(string: imageUrl) {
            productImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
            productImageView.image = UIImage(systemName: "photo")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.kf.cancelDownloadTask()
        productImageView.image = nil
    }
}
