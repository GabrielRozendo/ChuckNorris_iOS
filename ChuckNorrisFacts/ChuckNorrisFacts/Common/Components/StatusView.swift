//
//  StatusView.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import UIKit

enum StatusData {
    case loading
    case noResult
    case noInternet
    case error
    case emptyState

    var message: String {
        switch self {
        case .loading: return NSLocalizedString("status loading", comment: "")
        case .noResult: return NSLocalizedString("status no results", comment: "")
        case .noInternet: return NSLocalizedString("status no internet", comment: "")
        case .error: return NSLocalizedString("status generic error", comment: "")
        case .emptyState: return NSLocalizedString("status empty state", comment: "")
        }
    }

    var image: UIImage {
        switch self {
        case .loading: return UIImage.loading
        case .noResult: return UIImage.unavailable
        case .noInternet: return UIImage.noInternet
        case .error: return UIImage.error
        case .emptyState: return UIImage.emptyState
        }
    }
}

class StatusView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with status: StatusData) {
        image.image = status.image
        textLabel.apply(status.message, style: .status())
    }

    private lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = AppTextStyle.status().color
        image.heightAnchor.constraint(equalToConstant: 54).isActive = true
        image.widthAnchor.constraint(equalToConstant: 54).isActive = true
        image.contentMode = .scaleAspectFit
        image.accessibilityIdentifier = "StatusImage"
        image.accessibilityLabel = NSLocalizedString("StatusImage", comment: "")
        return image
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.accessibilityIdentifier = "StatusLabel"
        label.accessibilityLabel = NSLocalizedString("StatusLabel", comment: "")
        return label
    }()

    private func setupView() {
        addCornerRadius()

        addSubview(textLabel)
        addSubview(image)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: AppMetrics.defaultMargin),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppMetrics.defaultMargin),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppMetrics.defaultMargin),

            image.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: AppMetrics.defaultMargin),
            image.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppMetrics.defaultMargin)
        ])
    }
}
