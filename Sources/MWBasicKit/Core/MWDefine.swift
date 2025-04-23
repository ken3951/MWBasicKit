//
//  MWDefine.swift
//  MWBasic
//
//  Created by mwk_pro on 2019/4/4.
//  Copyright © 2019 mwk. All rights reserved.
//

//MARK: - BlockDefine

public typealias MWInoutCallback<T,R> = (T) -> R

public typealias MWVoidCallback = () -> Void

public typealias MWInCallback<T> = (T) -> Void

public typealias MWOutCallback<T> = () -> T

//MARK: - Protocol
public protocol MWTitleProtocol {
    var title: String {get}
}

public protocol MWIdProtocol {
    var customId: Int {get}
}

public protocol MWCodeProtocol {
    var code: String {get}
}

public protocol MWColorProtocol {
    var color: UIColor {get}
}

public protocol MWImageNameProtocol {
    var imageName: String {get}
}
