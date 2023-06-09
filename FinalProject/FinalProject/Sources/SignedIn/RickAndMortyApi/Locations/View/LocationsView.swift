//
//  LocationsView.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    //static let activityViewBackgroundColor = Theme.backgroundColor.withAlphaComponent(0.8)
    //static let activityIndicatorBackgroundColor = Theme.backgroundColor.withAlphaComponent(0)
    static let separatorColor = Theme.tableViewSeparatorColor
    static let cellHeight: CGFloat = 80
    static let footerHeight = CGFloat(PageButton.height + PageButton.verticalOffset)
    static let animationDelay = 0.5
}

private enum PageButton {
    static let borderWidth: CGFloat = 2
    static let cornerRadius: CGFloat = 15
    static var borderColor: CGColor { Theme.borderCgColor }
    static let backgroundColor = Theme.itemsBackgroundColor
    static let titleColor = Theme.textColor
    static let verticalOffset = 10
    static let height = 35
    static let width = 70
    
    enum Place {
        case left
        case right
        
        var xAxis: CGFloat {
            switch self {
            case .left:
                return UIScreen.main.bounds.width / 3 - CGFloat(PageButton.width / 6)
            case .right:
                return 2 * UIScreen.main.bounds.width / 3 + CGFloat(PageButton.width / 6)
            }
        }
        
        var image: UIImage {
            switch self {
            case .left:
                return UIImage(systemName: "lessthan")?
                    .withTintColor(Theme.tintColor)
                    .withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .right:
                return UIImage(systemName: "greaterthan")?
                    .withTintColor(Theme.tintColor)
                    .withRenderingMode(.alwaysOriginal) ?? UIImage()
            }
        }
    }
}

final class LocationsView: UIView {
    var nextPageTapHandler: (() -> Void)?
    var previousPageTapHandler: (() -> Void)?
    var cellTapHandler: ((Int) -> Void)?
    private var activityView: ActivityView?
    private let tableView: UITableView
    private var locations: [Location]
    private let nextPageButton: UIButton
    private let previousPageButton: UIButton
    
    init() {
        self.tableView = UITableView()
        self.nextPageButton = UIButton(type: .system)
        self.previousPageButton = UIButton(type: .system)
        self.locations = []
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.nextPageButton.layer.borderColor = PageButton.borderColor
        self.previousPageButton.layer.borderColor = PageButton.borderColor
    }
    
    func update(with locations: [Location], isFirstPage: Bool = false, isLastPage: Bool = false) {
        DispatchQueue.main.async {
            self.locations = locations
            self.tableView.setContentOffset(.zero, animated: false)
            self.tableView.reloadData()
            self.previousPageButton.isHidden = isFirstPage
            self.nextPageButton.isHidden = isLastPage
            self.closeActivityIndicator()
        }
    }
}

// MARK: configure extension
private extension LocationsView {
    func configure() {
        self.backgroundColor = Metrics.backgroundColor
        configureTableView()
        configureTableFooterView()
        self.activityView = ActivityView(superview: self)
        showActivityIndicator()
    }
    
    func configureTableFooterView() {
        let tableFooterView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: Metrics.footerHeight))
        tableFooterView.addSubview(self.nextPageButton)
        tableFooterView.addSubview(self.previousPageButton)
        configureNextPageButton()
        configurePreviousPageButton()
        self.tableView.tableFooterView = tableFooterView
    }
    
    func configureNextPageButton() {
        self.nextPageButton.addTarget(self, action: #selector(nextPageTapped(_:)), for: .touchUpInside)
        configure(pageButton: self.nextPageButton, place: .right)
    }
    
    func configurePreviousPageButton() {
        configure(pageButton: self.previousPageButton, place: .left)
        self.previousPageButton.addTarget(self, action: #selector(previousPageTapped(_:)), for: .touchUpInside)
    }
    
    func configure(pageButton: UIButton, place: PageButton.Place) {
        pageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(PageButton.verticalOffset)
            make.height.equalTo(PageButton.height)
            make.width.equalTo(PageButton.width)
            make.centerX.equalTo(place.xAxis)
        }
        pageButton.isUserInteractionEnabled = true
        pageButton.setImage(place.image, for: .normal)
        pageButton.layer.borderWidth = PageButton.borderWidth
        pageButton.backgroundColor = PageButton.backgroundColor
        pageButton.layer.borderColor = PageButton.borderColor
        pageButton.layer.cornerRadius = PageButton.cornerRadius
        pageButton.setTitleColor(PageButton.titleColor, for: .normal)
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.tableView.separatorColor = Metrics.separatorColor
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.className)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: method extension
private extension LocationsView {
    @objc func nextPageTapped(_ sender: UIButton) {
        showActivityIndicator()
        nextPageTapHandler?()
    }
    
    @objc func previousPageTapped(_ sender: UIButton) {
        showActivityIndicator()
        previousPageTapHandler?()
    }
    
    func showActivityIndicator() {
        self.activityView?.startAnimating()
    }
    
    func closeActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Metrics.animationDelay) {
            self.activityView?.stopAnimating()
        }
    }
}

// MARK: UITableView delegate, dataSource extension
extension LocationsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Metrics.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (0 ..< locations.count).contains(indexPath.row) else { return }
        cellTapHandler?(locations[indexPath.row].id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationTableViewCell.className, for: indexPath)
                as? LocationTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: self.locations[indexPath.row])
        return cell
    }
}
