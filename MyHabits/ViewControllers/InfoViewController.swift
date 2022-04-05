//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Павел Барташов on 26.03.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    private let infoView = InfoView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Информация"

        view.addSubviewsToAutoLayout(infoView)

        setupLayout()

        infoView.setup(with: Info())
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
