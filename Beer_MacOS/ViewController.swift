//
//  ViewController.swift
//  Beer_MacOS
//
//  Created by 임준화 on 2022/11/02.
//

import Cocoa
import SnapKit
import Then
import Kingfisher

class ViewController: NSViewController {

    private let beerTextView = NSTextView(frame: .zero).then{
        $0.alignment = .center
        $0.drawsBackground = false
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = NSFont(name: "Helvetica", size: 9)
    }
    
    private let beerImageView = NSImageView()
    
    private let service = WebService()
    
    func addView(){
        view.addSubview(beerTextView)
        view.addSubview(beerImageView)
    }
    
    func setLayout(){
        beerTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerImageView.snp.bottom).offset(10)
            make.width.equalTo(400)
            make.height.equalTo(200)
        }
        beerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(5)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        service.fetchData()
        loadBeer()
    }

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 200))
    }
    
    private func loadBeer() {
        service.beer.bind { [weak self] beer in
            guard let beer = beer else {return}
            DispatchQueue.main.async {
                self?.beerTextView.string = beer.description
                self?.beerImageView.kf.setImage(with: URL(string: beer.imageUrl))
            }
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

