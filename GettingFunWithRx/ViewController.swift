//
//  ViewController.swift
//  GettingFunWithRx
//
//  Created by n3tr on 3/31/2560 BE.
//  Copyright © 2560 Jirat Ki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ViewModelType {
    var currentText: Observable<String> { get }
    
    func increaseTapped()
    func decreaseTapped()
}

class ViewModel: ViewModelType {
    
    enum ActionType {
        case increase
        case decrease
    }
    
    let currentText: Observable<String>

    init() {
        let currentCount = tappedObservable
            .scan(0, accumulator: { (current, type) -> Int in
                print(type)
            switch type {
            case .increase:
                return current + 1
            case .decrease:
                return current - 1
            }
        }).startWith(0)
        
        currentText = currentCount.map({ "\($0)" })
    }
    
    private let tappedObservable = PublishSubject<ActionType>()
    func increaseTapped() {
        tappedObservable.onNext(.increase)
    }
    func decreaseTapped() {
        tappedObservable.onNext(.decrease)
    }
}

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var counterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.currentText.asDriver(onErrorJustReturn: "-").drive(counterLabel.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        viewModel.increaseTapped()
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        viewModel.decreaseTapped()
    }
}

