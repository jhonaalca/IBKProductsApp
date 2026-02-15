//
//  MenuViewController.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: MenuViewModel
    weak var coordinator: MenuCoordinator?
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Configuración"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorIconView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color del Tab Bar"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Toque para cambiar"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Versión 1.0.0"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithCurrentColor()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Menú"
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(colorCardView)
        view.addSubview(versionLabel)
        
        colorCardView.addSubview(colorIconView)
        colorCardView.addSubview(colorStackView)
        colorCardView.addSubview(colorButton)
        
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(colorValueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            colorCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            colorCardView.heightAnchor.constraint(equalToConstant: 100),
            
            colorIconView.leadingAnchor.constraint(equalTo: colorCardView.leadingAnchor, constant: 20),
            colorIconView.centerYAnchor.constraint(equalTo: colorCardView.centerYAnchor),
            colorIconView.widthAnchor.constraint(equalToConstant: 50),
            colorIconView.heightAnchor.constraint(equalToConstant: 50),
            
            colorStackView.leadingAnchor.constraint(equalTo: colorIconView.trailingAnchor, constant: 16),
            colorStackView.centerYAnchor.constraint(equalTo: colorCardView.centerYAnchor),
            colorStackView.trailingAnchor.constraint(equalTo: colorCardView.trailingAnchor, constant: -20),
            
            colorButton.topAnchor.constraint(equalTo: colorCardView.topAnchor),
            colorButton.leadingAnchor.constraint(equalTo: colorCardView.leadingAnchor),
            colorButton.trailingAnchor.constraint(equalTo: colorCardView.trailingAnchor),
            colorButton.bottomAnchor.constraint(equalTo: colorCardView.bottomAnchor),
            
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        colorButton.addTarget(self, action: #selector(selectColorTapped), for: .touchUpInside)
    }
    
    private func configureWithCurrentColor() {
        if let savedColor = viewModel.getCurrentTabBarColor() {
            colorIconView.backgroundColor = savedColor
            colorValueLabel.text = "Color personalizado"
            colorValueLabel.textColor = .systemBlue
        } else {
            colorIconView.backgroundColor = .systemBlue
            colorValueLabel.text = "Toque para cambiar"
            colorValueLabel.textColor = .systemGray
        }
    }
    
    // MARK: - Actions
    @objc private func selectColorTapped() {
        let currentColor = colorIconView.backgroundColor ?? .systemBlue
        coordinator?.showColorPicker(currentColor: currentColor)
    }
    
    // MARK: - Public Methods
    func updateColor(_ color: UIColor) {
        viewModel.saveTabBarColor(color)
    }
}

// MARK: - MenuViewModelDelegate
extension MenuViewController: MenuViewModelDelegate {
    func didUpdateTabBarColor() {
        configureWithCurrentColor()
    }
}
