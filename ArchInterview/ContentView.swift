//
//  ContentView.swift
//  ArchInterview
//
//  Created by Ash Censo on 17.11.2023.
//

import SwiftUI

/*
 
 General description
 Make an iOS application that simulates elevators for 9 floors buildings. Elevator is equipped with an emergency stop system that stops and blocks the elevator (in case of power outage). Control panels should be of 3 types:
 cabin control panel with button per floor;
 floor control panels with a call button. One per floor;
 dispatcher control panel with power switcher and cabin movement  direction indicator with number of floors closest to it.
 Behavior should be realistic, as it is possible. Simulation should be flexible and configurable for easy scaling.


 Cabin movement logic
 The cabin begins movement to the nearest floor with the button pressed on the cabin control panel. In other cases, it moves to the closest floor with the pressed button on floor control panels. Otherwise, it remains in place (immobile). The cabin can stop on the floor with the pressed button on floor control panels, if it is on the way down.


 Power switcher logic
 Power switcher is turned on at the start. On power turns-off the emergency stop system is activated. Cabin stops and all
 pressed buttons switch to unpressed state and all buttons become inactive. On power turns-on all buttons become active
 and the cabin is ready to move.


 UI/UX requirements
 All buttons should be circle with the number of floors on the left. Each control panel type should be visually separated from the other. There should be visible as many elements as possible simultaneously on the screen. It would be good that all elements are visible on screen.

 */

struct Context {
    let floorsCount: Int
    let elevatorController: AnyElevatorController
    let cabinControlPanel: AnyCabinControlPanel
    let floorControlPanels: [AnyFloorControlPanel]
    let dispatcherControlPanel: AnyDispatcherControlPanel
    
    init(floorsCount: Int) {
        self.floorsCount = floorsCount
        
        let elevatorController = ElevatorController()
        let cabinControlPanel = CabinControlPanel(elevatorController: elevatorController)
        elevatorController.cabinControlPanel = cabinControlPanel
        let floorControlPanels: [AnyFloorControlPanel] = (0..<floorsCount).map { index in
            let panel = FloorControlPanel(floorIndex: index + 1, elevatorController: elevatorController)
            elevatorController.floorControlPanels.append(panel)
            return panel
        }
        
        let dispatcherControlPanel = DispatcherControlPanel(elevatorController: elevatorController)
        elevatorController.dispatcherControlPanel = dispatcherControlPanel
        
        self.elevatorController = elevatorController
        self.cabinControlPanel = cabinControlPanel
        self.floorControlPanels = floorControlPanels
        self.dispatcherControlPanel = dispatcherControlPanel
    }
}


struct ContentView: View {
    var numberOfFloors: Int = 9
    
    var body: some View {
        HStack {
            VStack {
                Text("Cabin control panel")
           
                ForEach(0..<numberOfFloors) { floor in
                    Button {
                        
                    } label: {
                        Text("\(floor+1)")
                    }
                }
            }
            .background(Color.red)
            
            VStack {
                Text("Floor control panel")
                
                ForEach(0..<numberOfFloors) { floor in
                    Button {
                        
                    } label: {
                        Text("\(floor+1)")
                    }
                }
            }
            .background(Color.green)
            
            VStack {
                Text("Dispatcher control panel")
                
                Toggle(isOn: .constant(true), label: {
                    /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
                })
            }
            .background(Color.yellow)
        }
    }
}

#Preview {
    ContentView()
}
