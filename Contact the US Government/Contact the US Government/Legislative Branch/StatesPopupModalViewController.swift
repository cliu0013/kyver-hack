//
//  StatesPopopModalViewController.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/29/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit



class StatesPopopModalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO : When you choose a state in pickerView
        print("Pressed")
        let state = states[row]
        delegate?.stateChanged(newState: state)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = states[row]
        return state
    }
    
    
    var pickerView: UIPickerView!
    var states : [String] = []
    //var dismissViewTap: UITapGestureRecognizer?
    var dimView: UIView!
    weak var delegate: StateDelegate?
    
    let reuseIdentifier = "stateCellReuse"
    let cellHeight: CGFloat = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Choose a State"
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        dimView = UIView()
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimView.isHidden = true
        view.addSubview(dimView)
        
        let Alabama = "Alabama"
        let Alaska = "Alaska"
        let Arizona = "Arkansas"
        let California = "California"
        let Colorado = "Colorado"
        
        states = [Alabama, Alaska, Arizona, California, Colorado]
        
        pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.cornerRadius = 10
        pickerView.layer.masksToBounds = true
        pickerView.backgroundColor = .white
        view.addSubview(pickerView)
        view.tag = 10
        
        //dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width/6),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width/6),
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/2.5),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height/2.5)
            ])
        
        NSLayoutConstraint.activate([
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.topAnchor.constraint(equalTo:  view.topAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        //viewBoundaries = CGRect(x: theView.bounds.width/6, y: theView.bounds.height/5, width: (2*theView.bounds.width)/3, height: (1*theView.bounds.height)/2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesEnded(touches , with: event)
        if touches.first?.view?.tag == 10{
            print("ran")
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
}


