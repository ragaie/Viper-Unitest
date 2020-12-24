//
//  Coordinator.swift
//  FinishTask
//
//  Created by Ragaie Alfy on 12/1/20.
//

import Foundation

import UIKit

struct Coordinator {
    var rootNavigationController: UINavigationController?
   static var shared  = Coordinator()
    func pushView(viewcontroller: UIViewController) {
        if rootNavigationController != nil {
            rootNavigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}
