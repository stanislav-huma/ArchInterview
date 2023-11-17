//
//  AnyFloorControlPanel.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import Foundation

enum FloorControlPanelState {
    case selected
    case unselected
}

protocol AnyPublicFloorControlPanel: AnyObject {
    var floorIndex: Int { get }
    var state: FloorControlPanelState { get }
    func select()
}

protocol AnyFloorControlPanel: AnyPublicFloorControlPanel {
    var state: FloorControlPanelState { get set }
}

final class FloorControlPanel: AnyFloorControlPanel {
    var state: FloorControlPanelState = .unselected
    var floorIndex: Int
    private let elevatorController: AnyElevatorController
    
    init(floorIndex: Int, elevatorController: AnyElevatorController) {
        self.floorIndex = floorIndex
        self.elevatorController = elevatorController
    }
    
    func select() {
        elevatorController.selectFromFloor(floor: floorIndex)
    }
}
