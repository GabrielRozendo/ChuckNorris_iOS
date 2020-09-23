//
//  HomeViewController.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import RxSwift
import SafariServices
import UIKit

// MARK: - DELEGATE

protocol HomeViewControllerDelegate: class {
    func goToSearch()
}

// MARK: - CLASS

class HomeViewController: UIViewController {
    // MARK: - PUBLIC PROPERTIES

    let viewModel: HomeViewModelProtocol
    weak var delegate: HomeViewControllerDelegate?

    // MARK: - INIT

    init(with viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    private struct Metrics {
        static let statusMargin: CGFloat = 32
    }

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.didLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - PRIVATE METHODS

    private func setup() {
        setupConstraints()
        setupObservables()
    }

    private func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupObservables() {
        viewModel.loadingObservable.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else { return }

            OperationQueue.main.addOperation {
                if isLoading {
                    self.updateStatus(with: .loading)
                } else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true

                    if self.viewModel.facts.isEmpty {
                        self.updateStatus(with: self.viewModel.isDirty ? .noResult : .emptyState)
                    } else {
                        self.statusView.removeFromSuperview()
                    }
                }
            }
        }).disposed(by: disposeBag)

        viewModel.reloadObservable.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }

            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)

        viewModel.errorObservable.subscribe(onNext: { [weak self] error in
            guard let self = self else { return }

            switch error {
            case .noInternetConnection:
                self.updateStatus(with: .noInternet)
            default:
                self.updateStatus(with: .error)
            }
        }).disposed(by: disposeBag)
    }

    // MARK: - PUBLIC METHODS

    @objc func search() {
        delegate?.goToSearch()
    }

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "TableView"
        tableView.accessibilityLabel = NSLocalizedString("HomeTableView", comment: "")

        tableView.register(FactTableViewCell.self, forCellReuseIdentifier: FactTableViewCell.reuseIdentifier)

        return tableView
    }()

    private lazy var statusView: StatusView = {
        let view = StatusView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "StatusView"
        return view
    }()

    private func updateStatus(with status: StatusData) {
        OperationQueue.main.addOperation { [weak self] in
            guard let self = self else { return }

            self.view.addSubview(self.statusView)
            self.statusView.setup(with: status)

            NSLayoutConstraint.activate([
                self.statusView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.statusView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.statusView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                         constant: Metrics.statusMargin),
                self.statusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                          constant: -Metrics.statusMargin)
            ])
        }
    }
}

// MARK: - EXTENSION TABLEVIEW

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.facts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FactTableViewCell.reuseIdentifier)
            as? FactTableViewCell
        else { return UITableViewCell() }

        cell.delegate = self
        cell.fact = viewModel.facts[indexPath.row]
        return cell
    }
}

// MARK: - EXTENSION ACTIONS

extension HomeViewController: FactTableViewCellDelegate {
    func link(url: String) {
        guard let url = URL(string: url) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariViewController = SFSafariViewController(url: url, configuration: config)
        navigationController?.present(safariViewController, animated: true)
    }

    func share(text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }
}
