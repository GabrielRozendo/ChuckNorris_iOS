//
//  SearchViewController.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import RxSwift
import UIKit

// MARK: - PROTOCOL

protocol SearchViewControllerDelegate: class {
    func goToSearch(with term: String)
    func goToCategory(with category: FactCategory)
}

// MARK: - CLASS

class SearchViewController: UITableViewController {
    // MARK: - PRIVATE PROPERTIES

    private let disposeBag = DisposeBag()
    private let viewModel: SearchViewModelProtocol

    // MARK: - PUBLIC PROPERTIES

    weak var delegate: SearchViewControllerDelegate?

    // MARK: - INIT

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(with viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - UI

    private func setupView() {
        setupTableView()
    }

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)

        controller.delegate = self
        controller.searchBar.delegate = self
        controller.searchBar.searchTextField.delegate = self

        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.keyboardType = .alphabet
        controller.searchBar.returnKeyType = .search

        controller.searchBar.accessibilityIdentifier = "SearchBar"
        controller.searchBar.accessibilityLabel = NSLocalizedString("SearchBar", comment: "")

        return controller
    }()

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension

        tableView.accessibilityIdentifier = "TABLE VIEW"

        tableView.register(CategoryCollectionHeader.self,
                           forCellReuseIdentifier: CategoryCollectionHeader.reuseIdentifier)
    }
}

// MARK: - EXTENSION TABLEVIEW

extension SearchViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.pastSearchesTerm.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCollectionHeader.reuseIdentifier)
                as? CategoryCollectionHeader
            else { return UITableViewCell() }
            cell.categories = viewModel.categoriesToShow
            cell.delegate = self
            return cell

        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "PastSearchReuseIdentifier")
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.apply(viewModel.pastSearchesTerm[indexPath.row], style: .listItem())
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect(x: 8,
                             y: 0,
                             width: headerView.frame.width - AppMetrics.defaultMargin,
                             height: headerView.frame.height - AppMetrics.defaultMargin)
        let title = NSLocalizedString(section == 0 ? "search categories" : "search history", comment: "")
        label.apply(title, style: .subtitle())
        headerView.addSubview(label)

        return headerView
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 48
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            delegate?.goToSearch(with: viewModel.pastSearchesTerm[indexPath.row])
        }
    }
}

// MARK: - EXTENSION SEARCHBAR

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        if let term = searchBar.text, term.trimmingCharacters(in: .whitespaces).count >= 3 {
            searchController.isActive = false
            delegate?.goToSearch(with: term)
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }

        return text.count >= 3
    }
}

// MARK: - EXTENSION DELEGATE

extension SearchViewController: CategoryCollectionDelegate {
    func categoryDidTap(with category: FactCategory) {
        delegate?.goToCategory(with: category)
    }
}
