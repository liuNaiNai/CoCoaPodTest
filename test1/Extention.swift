//
//  Extention.swift
//  test1
//
//  Created by 刘坤 on 2018/3/20.
//  Copyright © 2018年 HiveOperation. All rights reserved.
//

import Foundation
import UIKit

public protocol TypeWrapperProtocol {
    associatedtype WrapperType
    var wrapperValue: WrapperType { get }
    init(value: WrapperType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public var wrapperValue: T
    public init(value: T) {
        self.wrapperValue = value
    }
}

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var fc: WrapperType { get}
    static var fc: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var fc: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    static var fc: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

extension UITableView: NamespaceWrappable {

}

extension TypeWrapperProtocol where WrapperType == UITableView {
    func registCell<T>(_ cellType: T.Type) where T : UITableViewCell {
        wrapperValue.register(cellType, forCellReuseIdentifier: "\(cellType)")
    }
}



