//
//  Coordinator.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController? { get }
    
    func start()
}
