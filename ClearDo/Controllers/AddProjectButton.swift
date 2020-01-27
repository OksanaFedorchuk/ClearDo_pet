//
//  AddProjectButton.swift
//  ClearDo
//
//  Created by Oksana on 26.01.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//

import UIKit

class AddProjectButton: UIButton {

//    func floatingButton(){
//        let btn = UIButton(type: .custom)
//        btn.frame = CGRect(x: 285, y: 485, width: 100, height: 100)
//        btn.setTitle("All Defects", for: .normal)
//        btn.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//        btn.clipsToBounds = true
//        btn.layer.cornerRadius = 50
//        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        btn.layer.borderWidth = 3.0
//
//    }
    
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
