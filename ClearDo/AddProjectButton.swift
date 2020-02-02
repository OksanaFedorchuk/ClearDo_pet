//
//  AddProjectButton.swift
//  ClearDo
//
//  Created by Oksana on 26.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class AddProjectButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    func setupButton() {
        backgroundColor = .white
        layer.cornerRadius = 33
        let image = UIImage(named: "plus")
        setImage(image, for: .normal)
    }

}
