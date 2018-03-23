//
//  UITableViewExtention.swift
//  test1
//
//  Created by 刘坤 on 2018/3/20.
//  Copyright © 2018年 HiveOperation. All rights reserved.
//

import UIKit

/* swift中的协议采用的是"associated Types"的方法来实现泛型功能的，通过"associatedtype"关键字来
    申明一个类型的占位符作为协议的一部分，
 */
//下面这种泛型的定义方式是有问题的,应该使用associatedtype来申明类型
//protocol GeneratorType<Element> {
//    mutating func next() -> Element?
//}

protocol GeneratorType {
    associatedtype Element
    mutating func next() -> Element?
}
/* 在swift 中，class struct enum都可以用参数化类型来表示泛型，只有在协议中需要使用'associatedtype'来表示参数化类型
 那么是为什么呢？总结一下有两点：
 1.采用<T>的参数化方式的泛型其实定义了整个类型的家族，在概念上对于一个可以实现的类型是有意义的，比如Array<Int>,Array<String>
 但是对于协议来说，协议表达含义是single的，你只会实现一次GeneratorType，而不会实现一个GeneratorType<String>协议，接着又实现另外一个
 GeneratorType<Int>协议
 2.协议在swift中有两个目的，第一个目的是用来实现多继承（swift语言被设计的是单继承的），第二个目的是强制实现者必须遵守自己所指定的泛型约束
 关键字associatedtype是用来实现第二个目的的，在协议中指定的Element，是用来控制next()方法的返回类型，而不是指定generatorType的类型
 */

public protocol Automobile {
    associatedtype FuelType     // 燃料类型
    associatedtype ExhaustType  // 排气类型
    func drive(fuel: FuelType) -> ExhaustType
}

public protocol Fuel {
    associatedtype ExhaustType
    func consume() -> ExhaustType // 消费
}

public protocol Exhaust {
    init()
    func emit() // 发出
}
/*以上是三个协议定义，机动车，燃料和尾气。机动车启动涉及到燃料和尾气所以定义了两个关联类型。
    燃料燃烧排放出尾气，所以内定了一个关联类型ExhaustType。
    尾气Exhaust不需要关联类型.
    接下来我们做具体实现
 */
public struct UnleadedGasoLine<E: Exhaust>: Fuel {
    public func consume() -> Exhaust {
        print(#function)
        return  E()
    }
}
public struct  CleanExhaust: Exhaust {
    public init() {
    }
    public func emit() {
        print(#function)
    }
}
public class Car<E: Exhaust, F: Fuel>: Automobile where F.ExhaustType == E {
    public func drive(fuel: F) -> E {
        print(#function)
        return fuel.consume()
    }
}
/* 尾气成为Car类型的一部分真的有意义么，从现实生活中看，这是没有意义的，因为尾气一定尊属与某一种燃料类型
    用燃料作为类型的一部分已经足够了，尾气成为类型的一部分出现了问题，我们需要在技术上进行泛型约束。调整car的实现
 */

public class NewCar<F: Fuel> : Automobile {
    public func drive(fuel: F) -> F.ExhaustType {
        return fuel.consume()
    }
}































