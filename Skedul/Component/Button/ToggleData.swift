//
//  ToggleData.swift
//  Skedul
//
//  Created by skedul on 04/11/24.
//

import SwiftUI

struct ToggleData {
    var isOn: Binding<Bool>
    var label: String
    var alertMessage: String
    var errorMessage: Binding<String>
}
