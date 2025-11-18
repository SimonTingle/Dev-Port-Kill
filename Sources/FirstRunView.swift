import SwiftUI

struct FirstRunView: View {
    @State private var currentStep = 0
    @State private var defaultPort: String = ""
    @State private var defaultProtocol: String = "tcp"
    @State private var autoStart: Bool = false
    @AppStorage("hasCompletedSetup") private var hasCompletedSetup = false
    
    let questions = [
        "Welcome to Kill Port App! 👋\n\nThis app helps you quickly kill processes on specific ports.",
        "What default port would you like to monitor?",
        "What's your preferred protocol?",
        "Would you like the app to start automatically when you login?"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(questions[currentStep])
                .multilineTextAlignment(.center)
                .padding()
            
            if currentStep == 1 {
                TextField("Enter default port", text: $defaultPort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
            }
            
            if currentStep == 2 {
                Picker("Protocol", selection: $defaultProtocol) {
                    Text("TCP").tag("tcp")
                    Text("UDP").tag("udp")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            }
            
            if currentStep == 3 {
                Toggle("Start at login", isOn: $autoStart)
                    .toggleStyle(SwitchToggleStyle())
            }
            
            HStack {
                if currentStep > 0 {
                    Button("Back") {
                        currentStep -= 1
                    }
                }
                
                Spacer()
                
                Button(currentStep == questions.count - 1 ? "Finish" : "Next") {
                    if currentStep == questions.count - 1 {
                        savePreferences()
                        hasCompletedSetup = true
                        // Close the window and exit modal
                        NSApp.stopModal()
                        NSApp.windows.first?.close()
                    } else {
                        currentStep += 1
                    }
                }
            }
        }
        .padding()
        .frame(width: 400, height: 300)
    }
    
    func savePreferences() {
        UserDefaults.standard.set(defaultPort, forKey: "defaultPort")
        UserDefaults.standard.set(defaultProtocol, forKey: "defaultProtocol")
        UserDefaults.standard.set(autoStart, forKey: "autoStart")
        
        if autoStart {
            setupAutoStart()
        }
    }
    
    func setupAutoStart() {
        // Implement auto-start setup
        print("Auto-start setup would go here")
    }
}
