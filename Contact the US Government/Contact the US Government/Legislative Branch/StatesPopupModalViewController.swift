//
//  StatesPopopModalViewController.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/29/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

//protocol ChangeSongDelegate: class {
//    func songNameChanged(newTitle: String, newIndexPath: IndexPath)
//    func songAlbumChanged(newTitle: String, newIndexPath: IndexPath)
//    func songArtistChanged(newTitle: String, newIndexPath: IndexPath)
//}

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
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = states[row]
        return state
    }
    
    
    var pickerView: UIPickerView!
    var states : [String] = []
    //var dismissViewTap: UITapGestureRecognizer?
    
    let reuseIdentifier = "stateCellReuse"
    let cellHeight: CGFloat = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Choose a State"
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
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
        view.addSubview(pickerView)
        view.tag = 10
        
        //dismissViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        // Setup the constraints for our views
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if touches.first?.view?.tag == 10{
            print("ran")
            dismiss(animated: true, completion: nil)
            super.touchesEnded(touches , with: event)
        }
    }
    
    
}

//extension ViewController: ChangeSongDelegate{
//    func songNameChanged(newTitle: String, newIndexPath: IndexPath) {
//        let song = songs[newIndexPath.row]
//        song.name = newTitle
//        tableView.reloadData()
//    }
//    func songAlbumChanged(newTitle: String, newIndexPath: IndexPath) {
//        let song = songs[newIndexPath.row]
//        song.album = newTitle
//        tableView.reloadData()
//    }
//    func songArtistChanged(newTitle: String, newIndexPath: IndexPath) {
//        let song = songs[newIndexPath.row]
//        song.artist = newTitle
//        tableView.reloadData()
//    }
//
//
//}

