//
//  URLEmbeddedViewPresenter.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// Use for Test
protocol URLEmbeddedViewPresenterProtocol: class {
    var shouldContinueDownloadingWhenCancel: Bool { get set }
    var url: URL? { get }
    func setURLString(_ urlString: String)
    func load(urlString: String, completion: ((Result<Void>) -> Void)?)
    func load(_ completion: ((Result<Void>) -> Void)?)
    func cancelLoading()
}

final class URLEmbeddedViewPresenter: URLEmbeddedViewPresenterProtocol {

    private struct Const {
        static let faviconURL = "http://www.google.com/s2/favicons?domain="
    }

    private weak var view: URLEmbeddedViewProtocol?
    private let dataProvider: OGDataProviderProtocol
    private var task: Task?

    private(set) var url: URL?
    var shouldContinueDownloadingWhenCancel = true

    init(view: URLEmbeddedViewProtocol,
         dataProvider: OGDataProviderProtocol = OGDataProvider.shared) {
        self.view = view
        self.dataProvider = dataProvider
    }

    func setURLString(_ urlString: String) {
        self.url = URL(string: urlString)
    }

    func load(urlString: String, completion: ((Result<Void>) -> Void)?) {
        guard let url = URL(string: urlString) else {
            completion?(.failure(URLEmbeddedViewError.invalidURLString(urlString)))
            return
        }
        self.url = url
        load(completion)
    }

    func load(_ completion: ((Result<Void>) -> Void)?) {
        guard let url = url else {
            return
        }

        view?.prepareViewsForReuse()
        view?.updateActivityView(isHidden: false)

        task = dataProvider.fetchOGData(urlString: url.absoluteString) { [weak view, url] ogData, error in
            DispatchQueue.main.async {
                view?.updateActivityView(isHidden: true)
                view?.layoutIfNeeded()

                let host = url.host ?? ""
                let faciconURLString = Const.faviconURL + host

                if let error = error {
                    view?.updateViewAsEmpty(with: url, faciconURLString: faciconURLString)
                    completion?(.failure(error))
                } else if ogData.isEmpty {
                    view?.updateViewAsEmpty(with: url, faciconURLString: faciconURLString)
                    completion?(.success(()))
                } else {
                    view?.updateLinkIconView(isHidden: true)

                    if let pageTitle = ogData.pageTitle {
                        view?.updateTitleLabel(pageTitle: pageTitle)
                    } else {
                        view?.updateTitleLabel(pageTitle: url.absoluteString)
                    }

                    view?.updateDescriptionLabel(pageDescription: ogData.pageDescription)
                    view?.updateImageView(urlString: ogData.imageUrl?.absoluteString)

                    view?.updateDomainLabel(host: host)
                    view?.updateDomainImageView(urlString: faciconURLString)

                    view?.layoutIfNeeded()
                    completion?(.success(()))
                }
            }
        }
    }

    func cancelLoading() {
        view?.updateActivityView(isHidden: true)
        guard let task = task else {
            return
        }
        dataProvider.cancelLoading(task, shouldContinueDownloading: shouldContinueDownloadingWhenCancel)
    }
}
