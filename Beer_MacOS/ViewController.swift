//
//  ViewController.swift
//  Beer_MacOS
//
//  Created by 임준화 on 2022/11/02.
//

import Cocoa
import SnapKit
import Then

class ViewController: NSViewController {

    let beerTextView = NSTextView(frame: .zero).then{
        $0.alignment = .center
        $0.drawsBackground = false
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let service = WebService()
    
    func addView(){
        view.addSubview(beerTextView)
    }
    
    func setLayout(){
        beerTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(60)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        Task{
            loadBeer()
        }
    }

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 200))
    }
    
    private func loadBeer(){
        WebService().fetchData()
        service.beer.bind { [weak self] beer in
            guard let beer = beer else {return}
            DispatchQueue.main.async {
                self?.beerTextView.string = beer.description
            }
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

