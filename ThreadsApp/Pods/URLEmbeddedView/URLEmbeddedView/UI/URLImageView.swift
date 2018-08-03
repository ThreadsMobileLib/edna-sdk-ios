//
//  URLImageView.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/07.
//
//

import UIKit

protocol URLImageViewProtocol: class {
    func updateActivityView(isHidden: Bool)
    func updateImage(_ image: UIImage?)
}

final class URLImageView: UIImageView {

    #if os(iOS)
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    #elseif os(tvOS)
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    #endif
    private lazy var presenter: URLImageViewPresenterProtocol = URLImageViewPresenter(view: self)

    var activityViewHidden: Bool = false
    var shouldContinueDownloadingWhenCancel: Bool {
        set { presenter.shouldContinueDownloadingWhenCancel = newValue }
        get { return presenter.shouldContinueDownloadingWhenCancel }
    }

    init(presenter: URLImageViewPresenterProtocol? = nil) {
        super.init(frame: .zero)
        if let presenter = presenter {
            self.presenter = presenter
        }
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        _ = presenter
        activityView.hidesWhenStopped = true
        addSubview(activityView)
        addConstraints(with: activityView, size: .init(width: 30, height: 30))
        addConstraints(with: activityView, center: .zero)
    }
    
    func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)? = nil) {
        presenter.loadImage(urlString: urlString, completion: completion)
    }

    func cancelLoadingImage() {
        presenter.cancelLoadingImage()
    }
}

extension URLImageView: URLImageViewProtocol {
    func updateActivityView(isHidden: Bool) {
        activityView.isHidden = isHidden
        if isHidden {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

    func updateImage(_ image: UIImage?) {
        self.image = image
    }
}

