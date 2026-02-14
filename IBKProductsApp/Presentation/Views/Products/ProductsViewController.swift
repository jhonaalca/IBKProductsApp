//
//  ProductsViewController.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

class ProductsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: ProductsViewModel
    weak var coordinator: ProductsCoordinator?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Initializers
    init(viewModel: ProductsViewModel) {
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
        setupTableView()
        viewModel.loadInitialProducts()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "Productos"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshProducts), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func refreshProducts() {
        viewModel.loadInitialProducts()
    }
}

// MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell,
              let product = viewModel.product(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: product)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = viewModel.product(at: indexPath.row) else { return }
        coordinator?.showProductDetail(product)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfProducts - 3 {
            viewModel.loadMoreProducts()
        }
    }
}

// MARK: - ProductsViewModelDelegate
extension ProductsViewController: ProductsViewModelDelegate {
    func didLoadProducts() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func didFailWithError(_ error: String) {
        refreshControl.endRefreshing()
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
