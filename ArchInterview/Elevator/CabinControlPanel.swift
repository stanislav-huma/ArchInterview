//
//  AnyCabinControlPanel.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import Foundation

protocol AnyPublicCabinControlPanel: AnyObject {
    var selectedFloors: [Int] { get }
    func select(floor: Int)
}

protocol AnyCabinControlPanel: AnyPublicCabinControlPanel {
    var selectedFloors: [Int] { get set }
}

final class CabinControlPanel: AnyCabinControlPanel {
    var selectedFloors: [Int] = []
    
    private let elevatorController: AnyElevatorController
    
    init(elevatorController: AnyElevatorController) {
        self.elevatorController = elevatorController
    }
}

// MARK: - AnyCabinControlPanel

extension CabinControlPanel {
    func select(floor: Int) {
        elevatorController.selectFromCabin(floor: floor)
    }
}
