//
//  MVVM.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation

enum ViewModelTable {
    static var viewModels = [String: AnyObject?]()
}

protocol ViewModel: AnyObject {
    associatedtype Action
    associatedtype State

    var action: Action { get }
    var state: State { get }
}

protocol View: AnyObject {
    associatedtype ViewModel
    
    var isBeforePresented: Bool { get set }
    
    func bind(to viewModel: ViewModel)
}

extension View {
    var identifier: String { .init(describing: self) }
    
    var viewModel: ViewModel? {
        get {
            guard let object = ViewModelTable.viewModels[identifier],
                  let viewModel = object as? ViewModel else {
                      return nil
            }
            return viewModel
        }
        set {
            if let viewModel = newValue {
                bind(to: viewModel)
            }
            ViewModelTable.viewModels[identifier] = newValue as AnyObject?
        }
    }
}
