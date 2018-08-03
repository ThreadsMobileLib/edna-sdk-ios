//
//  URLImageViewPresenter.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

/// Use for Test
protocol URLImageViewPresenterProtocol: class {
    var shouldContinueDownloadingWhenCancel: Bool { get set }
    func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)?)
    func cancelLoadingImage()
}

final class URLImageViewPresenter: URLImageViewPresenterProtocol {

    private let imageProvider: OGImageProviderProtocol
    private var task: Task?
    private weak var view: URLImageViewProtocol?

    var shouldContinueDownloadingWhenCancel = true

    init(view: URLImageViewProtocol,
         imageProvider: OGImageProviderProtocol = OGImageProvider.shared) {
        self.view = view
        self.imageProvider = imageProvider
    }

    func loadImage(urlString: String, completion: ((Result<UIImage>) -> Void)?) {
        cancelLoadingImage()
        view?.updateActivityView(isHidden: false)
        task = imageProvider.loadImage(urlString: urlString) { [weak view] result in
            DispatchQueue.main.async {
                view?.updateActivityView(isHidden: true)
                view?.updateImage(result.value)
                completion?(result)
            }
        }
    }

    func cancelLoadingImage() {
        view?.updateActivityView(isHidden: true)

        guard let task = task else {
            return
        }
        imageProvider.cancelLoading(task,
                                    shouldContinueDownloading: shouldContinueDownloadingWhenCancel)
    }
}
