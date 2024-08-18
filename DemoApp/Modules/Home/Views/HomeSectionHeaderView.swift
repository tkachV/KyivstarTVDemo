//
//  HomeSectionHeaderView.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import Combine

typealias SectionModel = HomeViewController.Collection.SectionModel

enum HomeSectionHeaderAction {
    case delete(SectionModel)
}

final class HomeSectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    static let elementKind = "SectionHeaderView"

    
    var sectionModel: SectionModel?
    let viewOutputSubject = PassthroughSubject<HomeSectionHeaderAction, Never>()

    // MARK: - UI Elements
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkText//appDarkBlack()
        return label
    }()
    
    private var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Del", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textColor = .blue

        button.isHidden = true
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        actionButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        actionButton.isHidden = true
    }
    
    // MARK: - Setup
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate( [
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func deleteButtonAction() {
        guard let model = sectionModel else { return }
        viewOutputSubject.send(.delete(model))
    }
    
    // MARK: - Configuration
    func configure(_ section: SectionModel,
                   canBeDeleted: Bool) {
        titleLabel.text = section.section.title
        actionButton.isHidden = !canBeDeleted
        
        sectionModel = section
    }
}
