import SwiftUI

struct ConfigView: View {
    @State private var portNumber: String = ""
    @State private var selectedProtocol: String = "tcp"
    @State private var killResults: [String] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Kill Port")
                .font(.headline)
            
            // Port Input
            VStack(alignment: .leading) {
                Text("Port Number:")
                TextField("Enter port number", text: $portNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Protocol Selection
            VStack(alignment: .leading) {
                Text("Protocol:")
                Picker("Protocol", selection: $selectedProtocol) {
                    Text("TCP").tag("tcp")
                    Text("UDP").tag("udp")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            // Kill Button
            Button(action: killPort) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                    Text("Kill Port")
                }
            }
            .disabled(portNumber.isEmpty || isLoading)
            
            // Results
            if !killResults.isEmpty {
                VStack(alignment: .leading) {
                    Text("Results:")
                        .font(.headline)
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(killResults, id: \.self) { result in
                                Text(result)
                                    .font(.system(.body, design: .monospaced))
                                    .padding(4)
                            }
                        }
                    }
                    .frame(height: 100)
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 400)
    }
    
    func killPort() {
        guard let port = Int(portNumber) else {
            killResults.append("Error: Invalid port number")
            return
        }
        
        isLoading = true
        
        // Use Process to run kill-port command
        let process = Process()
        process.launchPath = "/usr/bin/env"
        process.arguments = ["npx", "kill-port", portNumber]
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            
            let output = String(data: outputData, encoding: .utf8) ?? ""
            let error = String(data: errorData, encoding: .utf8) ?? ""
            
            DispatchQueue.main.async {
                if !output.isEmpty {
                    killResults.append("Success: \(output)")
                }
                if !error.isEmpty {
                    killResults.append("Error: \(error)")
                }
                isLoading = false
            }
            
        } catch {
            DispatchQueue.main.async {
                killResults.append("Failed to run command: \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
