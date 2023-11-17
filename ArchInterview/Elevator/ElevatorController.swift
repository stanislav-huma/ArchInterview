//
//  ElevatorController.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import Foundation

enum PowerState {
    case on
    case off
}

protocol AnyElevatorController {
    var powerState: PowerState { get }
    
    var currentFloor: Int { get }
    
    func selectFromCabin(floor: Int)
    func selectFromFloor(floor: Int)
    func turnPowerState()
}

final class ElevatorController: AnyElevatorController {
    var powerState: PowerState = .on {
        didSet {
            switch powerState {
            case .on:
                break
            case .off:
                selectedFloorsFromCabin = []
            }
            
            dispatcherControlPanel?.powerState = powerState
        }
    }
    
    var currentFloor: Int = 0
    
    private(set) var selectedFloorsFromCabin: [Int] = [] {
        didSet {
            cabinControlPanel?.selectedFloors = selectedFloorsFromCabin
        }
    }
    
    private(set) var selectedFloorsFromFloor: [Int] = [] {
        didSet {
            floorControlPanels.forEach { floorPanel in
                if selectedFloorsFromFloor.contains(floorPanel?.floorIndex ?? -1) {
                    floorPanel?.state = .selected
                }
            }
        }
    }
    
    weak var cabinControlPanel: AnyCabinControlPanel?
    var floorControlPanels: [AnyFloorControlPanel?] = []
    weak var dispatcherControlPanel: AnyDispatcherControlPanel?
    
    func selectFromCabin(floor: Int) {
        guard powerState == .on, !selectedFloorsFromCabin.contains(floor) else {
            return
        }
        
        selectedFloorsFromCabin.append(floor)
    }
    
    func selectFromFloor(floor: Int) {
        guard !selectedFloorsFromFloor.contains(floor) else {
            return
        }
        
        selectedFloorsFromFloor.append(floor)
    }
    
    func turnPowerState() {
        switch powerState {
        case .on:
            powerState = .off
        case .off:
            powerState = .on
        }
    }
}
