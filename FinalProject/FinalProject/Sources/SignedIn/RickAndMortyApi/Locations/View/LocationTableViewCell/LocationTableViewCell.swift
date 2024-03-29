//
//  LocationTableViewCell.swift
//  FinalProject
//
//  Created by 1okmon on 30.05.2023.
//

import UIKit

private enum Metrics {
    static let verticalOffset = 5
    static let horizontalOffset = 15
    static let labelHeight = 30
    static let residentsCountPrefix = "Количество жителей: "
    static let fontForName = UIFont.systemFont(ofSize: 20)
    static let fontForResidentsCount = UIFont.systemFont(ofSize: 16)
}

final class LocationTableViewCell: UITableViewCell {
    private let locationNameLabel: UILabel
    private let residentsLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.locationNameLabel = UILabel()
        self.residentsLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with location: Location) {
        self.locationNameLabel.text = location.name
        self.residentsLabel.text = Metrics.residentsCountPrefix + location.residentsCount.description
    }
}

private extension LocationTableViewCell {
    func configure() {
        self.accessoryType = .disclosureIndicator
        self.configureLocationNameLabel()
        self.configureResidentsLabel()
    }
    
    func configureLocationNameLabel() {
        self.addSubview(self.locationNameLabel)
        self.locationNameLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().offset(Metrics.horizontalOffset)
            make.top.equalToSuperview().offset(Metrics.verticalOffset)
            make.height.equalTo(Metrics.labelHeight)
        }
        self.locationNameLabel.font = Metrics.fontForName
    }
    
    func configureResidentsLabel() {
        self.addSubview(self.residentsLabel)
        self.residentsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.locationNameLabel.snp.bottom).offset(Metrics.verticalOffset)
            make.height.equalTo(Metrics.labelHeight)
            make.trailing.leading.equalToSuperview().offset(Metrics.horizontalOffset)
        }
        self.residentsLabel.font = Metrics.fontForResidentsCount
    }
}
