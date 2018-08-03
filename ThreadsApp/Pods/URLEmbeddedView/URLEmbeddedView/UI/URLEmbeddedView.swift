//
//  URLEmbeddedView.swift
//  URLEmbeddedView
//
//  Created by Taiki Suzuki on 2016/03/06.
//
//

import UIKit

protocol URLEmbeddedViewProtocol: class {
    func layoutIfNeeded()
    func prepareViewsForReuse()
    func updateActivityView(isHidden: Bool)
    func updateViewAsEmpty(with url: URL, faciconURLString: String)
    func updateLinkIconView(isHidden: Bool)
    func updateTitleLabel(pageTitle: String)
    func updateDescriptionLabel(pageDescription: String?)
    func updateImageView(urlString: String?)
    func updateDomainLabel(host: String)
    func updateDomainImageView(urlString: String)
}

@objc open class URLEmbeddedView: UIView {
    
    //MARK: - Properties
    private let alphaView = UIView()
    
    let imageView = URLImageView()
    private var imageViewWidthConstraint: NSLayoutConstraint?
    
    private let titleLabel = UILabel()
    private var titleLabelHeightConstraint: NSLayoutConstraint?
    private let descriptionLabel = UILabel()
    
    private let domainConainter = UIView()
    private var domainContainerHeightConstraint: NSLayoutConstraint?
    private let domainLabel = UILabel()
    private let domainImageView = URLImageView()
    private var domainImageViewToDomainLabelConstraint: NSLayoutConstraint?
    private var domainImageViewWidthConstraint: NSLayoutConstraint?

    #if os(iOS)
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    #elseif os(tvOS)
    private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
    #endif
    private lazy var linkIconView = LinkIconView(frame: self.bounds)

    private lazy var presenter: URLEmbeddedViewPresenterProtocol = URLEmbeddedViewPresenter(view: self)

    @objc open let textProvider: AttributedTextProvider = .shared
    
    @objc open var didTapHandler: ((URLEmbeddedView, URL?) -> Void)?
    @objc open var shouldContinueDownloadingWhenCancel: Bool {
        get { return presenter.shouldContinueDownloadingWhenCancel }
        set {
            presenter.shouldContinueDownloadingWhenCancel = newValue
            domainImageView.shouldContinueDownloadingWhenCancel = newValue
            imageView.shouldContinueDownloadingWhenCancel = newValue
        }
    }

    convenience init(presenter: URLEmbeddedViewPresenterProtocol?) {
        self.init(frame: .zero)
        if let presenter = presenter {
            self.presenter = presenter
        }
    }
    
    @objc public convenience init() {
        self.init(frame: .zero)
    }
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
        setInitialiValues()
        configureViews()
    }
    
    @objc public convenience init(url: String) {
        self.init(url: url, frame: .zero)
    }
    
    @objc public init(url: String, frame: CGRect) {
        super.init(frame: frame)
        presenter.setURLString(url)
        setInitialiValues()
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setInitialiValues()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    open func prepareViewsForReuse() {
        cancelLoading()
        imageView.image = nil
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        domainLabel.attributedText = nil
        domainImageView.image = nil
        linkIconView.isHidden = true
    }
    
    fileprivate func setInitialiValues() {
        borderColor = .lightGray
        borderWidth = 1
        cornerRaidus = 8
    }
    
    fileprivate func configureViews() {
        setNeedsDisplay()
        layoutIfNeeded()
        
        textProvider.didChangeValue = { [weak self] style, attribute, value in
            self?.handleTextProviderChanged(style, attribute: attribute, value: value)
        }

        addSubview(linkIconView)
        addConstraints(with: linkIconView,
                       edges: .init(top: 0, left: 0, bottom: 0))
        addConstraint(.init(item: linkIconView,
                            attribute: .width,
                            relatedBy: .equal,
                            toItem: linkIconView,
                            attribute: .height,
                            multiplier: 1,
                            constant: 0))
        linkIconView.clipsToBounds = true
        linkIconView.isHidden = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        addConstraints(with: imageView,
                       edges: .init(top: 0, left: 0, bottom: 0))
        changeImageViewWidthConstrain(nil)
        
        titleLabel.numberOfLines = textProvider[.title].numberOfLines
        addSubview(titleLabel)
        addConstraints(with: titleLabel,
                       edges: .init(top: 8, right: -12))
        addConstraint(.init(item: titleLabel,
                            attribute: .left,
                            relatedBy: .equal,
                            toItem: imageView,
                            attribute: .right,
                            multiplier: 1,
                            constant: 12))
        changeTitleLabelHeightConstraint()
        
        addSubview(domainConainter)
        addConstraints(with: domainConainter,
                       edges: .init(right: -12, bottom: -10))
        addConstraint(.init(item: domainConainter,
                            attribute: .left,
                            relatedBy: .equal,
                            toItem: imageView,
                            attribute: .right,
                            multiplier: 1,
                            constant: 12))
        changeDomainContainerHeightConstraint()
        
        descriptionLabel.numberOfLines = textProvider[.description].numberOfLines
        addSubview(descriptionLabel)
        addConstraints(with: descriptionLabel, edges: .init(right: -12))
        addConstraints(with: descriptionLabel,
                       size: .init(height: 0),
                       relatedBy: .greaterThanOrEqual)
        addConstraints([
            .init(item: descriptionLabel,
                  attribute: .top,
                  relatedBy: .equal,
                  toItem: titleLabel,
                  attribute: .bottom,
                  multiplier: 1,
                  constant: 2),
            .init(item: descriptionLabel,
                  attribute: .bottom,
                  relatedBy: .lessThanOrEqual,
                  toItem: domainConainter,
                  attribute: .top,
                  multiplier: 1,
                  constant: 4),
            .init(item: descriptionLabel,
                  attribute: .left,
                  relatedBy: .equal,
                  toItem: imageView,
                  attribute: .right,
                  multiplier: 1,
                  constant: 12)
        ])
        
        domainImageView.activityViewHidden = true
        domainConainter.addSubview(domainImageView)
        domainConainter.addConstraints(with: domainImageView,
                                       edges: .init(top: 0, left: 0, bottom: 0))
        changeDomainImageViewWidthConstraint(nil)
        
        domainLabel.numberOfLines = textProvider[.domain].numberOfLines
        domainConainter.addSubview(domainLabel)
        domainConainter.addConstraints(with: domainLabel,
                                       edges: .init(top: 0, right: 0, bottom: 0))
        changeDomainImageViewToDomainLabelConstraint(nil)
        
        activityView.hidesWhenStopped = true
        addSubview(activityView)
        addConstraints(with: activityView, center: .zero)
        addConstraints(with: activityView, size: .init(width: 30, height: 30))
        
        alphaView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        alphaView.alpha = 0
        addSubview(alphaView)
        addConstraints(with: alphaView, edges: .zero)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        alphaView.alpha = 1
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        alphaView.alpha = 0
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        alphaView.alpha = 0
        didTapHandler?(self, presenter.url)
    }

    //MARK: - Image layout
    private func changeImageViewWidthConstrain(_ constant: CGFloat?) {
        if let constraint = imageViewWidthConstraint {
            removeConstraint(constraint)
        }
        let constraint: NSLayoutConstraint
        if let constant = constant {
            constraint = NSLayoutConstraint(item: imageView,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        } else {
            constraint = NSLayoutConstraint(item: imageView,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: imageView,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: 0)
        }
        addConstraint(constraint)
        imageViewWidthConstraint = constraint
    }
    
    private func changeDomainImageViewWidthConstraint(_ constant: CGFloat?) {
        if let constraint = domainImageViewWidthConstraint {
            removeConstraint(constraint)
        }
        let constraint: NSLayoutConstraint
        if let constant = constant {
            constraint = NSLayoutConstraint(item: domainImageView,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        } else {
            constraint = NSLayoutConstraint(item: domainImageView,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: domainConainter,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: 0)
        }
        addConstraint(constraint)
        domainImageViewWidthConstraint = constraint
    }
    
    private func changeDomainImageViewToDomainLabelConstraint(_ constant: CGFloat?) {
        let constant = constant ?? (textProvider[.domain].font.lineHeight / 5)
        if let constraint = domainImageViewToDomainLabelConstraint {
            if constant == constraint.constant { return }
            removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(item: domainLabel,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: domainImageView,
                                            attribute: .right,
                                            multiplier: 1,
                                            constant: constant)
        addConstraint(constraint)
        domainImageViewToDomainLabelConstraint = constraint
    }
    
    private func changeTitleLabelHeightConstraint() {
        let constant = textProvider[.title].font.lineHeight
        if let constraint = titleLabelHeightConstraint {
            if constant == constraint.constant { return }
            removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(item: titleLabel,
                                            attribute: .height,
                                            relatedBy: .greaterThanOrEqual,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        addConstraint(constraint)
        titleLabelHeightConstraint = constraint
    }
    
    private func changeDomainContainerHeightConstraint() {
        let constant = textProvider[.domain].font.lineHeight
        if let constraint = domainContainerHeightConstraint {
            if constant == constraint.constant { return }
            removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(item: domainConainter,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        addConstraint(constraint)
        domainContainerHeightConstraint = constraint
    }
    
    //MARK: - Attributes
    private func handleTextProviderChanged(_ style: AttributeManager.Style, attribute: AttributeManager.Attribute, value: Any) {
        switch style {
        case .title:       didChangeTitleAttirbute(attribute, value: value)
        case .domain:      didChangeDomainAttirbute(attribute, value: value)
        case .description: didChangeDescriptionAttirbute(attribute, value: value)
        case .noDataTitle: didChangeNoDataTitleAttirbute(attribute, value: value)
        }
    }
    
    private func didChangeTitleAttirbute(_ attribute: AttributeManager.Attribute, value: Any) {
        switch attribute {
        case .font: changeDomainContainerHeightConstraint()
        case .fontColor: break
        case .numberOfLines: break
        }
    }
    
    private func didChangeDomainAttirbute(_ attribute: AttributeManager.Attribute, value: Any) {
        switch attribute {
        case .font: changeDomainContainerHeightConstraint()
        case .fontColor: break
        case .numberOfLines: break
        }
    }
    
    private func didChangeDescriptionAttirbute(_ attribute: AttributeManager.Attribute, value: Any) {
        switch attribute {
        case .font: break
        case .fontColor: break
        case .numberOfLines: break
        }
    }
    
    private func didChangeNoDataTitleAttirbute(_ attribute: AttributeManager.Attribute, value: Any) {
        switch attribute {
        case .font: changeTitleLabelHeightConstraint()
        case .fontColor: break
        case .numberOfLines: break
        }
    }
    
    //MARK: - Load
    @objc public func load(withURLString urlString: String, completion: ((Error?) -> Void)? = nil) {
        load(urlString: urlString) { completion?($0.error) }
    }
    
    @nonobjc public func load(urlString: String, completion: ((Result<Void>) -> Void)? = nil) {
        presenter.load(urlString: urlString, completion: completion)
    }
    
    @objc public func load(_ completion: ((Error?) -> Void)? = nil) {
        load { completion?($0.error) }
    }
    
    @nonobjc public func load(_ completion: ((Result<Void>) -> Void)? = nil) {
        presenter.load(completion)
    }
    
    @objc public func cancelLoading() {
        domainImageView.cancelLoadingImage()
        imageView.cancelLoadingImage()
        presenter.cancelLoading()
    }
}

extension URLEmbeddedView: URLEmbeddedViewProtocol {
    func updateActivityView(isHidden: Bool) {
        activityView.isHidden = isHidden
        if isHidden {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

    func updateViewAsEmpty(with url: URL, faciconURLString: String) {
        imageView.image = nil
        titleLabel.attributedText = textProvider[.noDataTitle].attributedText(url.absoluteString)
        descriptionLabel.attributedText = nil
        domainLabel.attributedText = textProvider[.domain].attributedText(url.host ?? "")
        changeDomainImageViewWidthConstraint(0)
        updateDomainImageView(urlString: faciconURLString)
        linkIconView.isHidden = false
    }

    func updateLinkIconView(isHidden: Bool) {
        linkIconView.isHidden = isHidden
    }

    func updateTitleLabel(pageTitle: String) {
        titleLabel.attributedText = textProvider[.title].attributedText(pageTitle)
    }

    func updateDescriptionLabel(pageDescription: String?) {
        if let pageDescription = pageDescription {
            descriptionLabel.attributedText = textProvider[.description].attributedText(pageDescription)
        } else {
            descriptionLabel.attributedText = nil
        }
    }

    func updateImageView(urlString: String?) {
        if let urlString = urlString {
            imageView.loadImage(urlString: urlString) { [weak self] in
                switch $0 {
                case .success:
                    self?.changeImageViewWidthConstrain(nil)
                case .failure:
                    self?.changeImageViewWidthConstrain(0)
                }
                self?.layoutIfNeeded()
            }
        } else {
            changeImageViewWidthConstrain(0)
            imageView.image = nil
        }
    }

    func updateDomainLabel(host: String) {
        domainLabel.attributedText = textProvider[.domain].attributedText(host)
    }

    func updateDomainImageView(urlString: String) {
        domainImageView.loadImage(urlString: urlString) { [weak self] in
            switch $0 {
            case .success:
                self?.changeDomainImageViewWidthConstraint(nil)
                self?.changeDomainImageViewToDomainLabelConstraint(nil)
            case .failure:
                self?.changeDomainImageViewWidthConstraint(0)
                self?.changeDomainImageViewToDomainLabelConstraint(0)
            }
            self?.layoutIfNeeded()
        }
    }
}
