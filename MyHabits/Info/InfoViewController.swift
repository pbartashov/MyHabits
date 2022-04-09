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
        infoView.setConstraintsToSafeArea(of: view)

        infoView.setup(with: InfoModel())
    }
}
