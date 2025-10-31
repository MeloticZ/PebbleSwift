import SwiftUI
import RiveRuntime

// MARK: - Main Content View
struct ContentView: View {
    @StateObject private var basketballVM = RiveViewModel(fileName: "pebble")
    @StateObject private var iconVM = RiveViewModel(
        fileName: "223-931-android-fun",
        stateMachineName: "State Machine 1",
        artboardName: "New Artboard",
    )
    @StateObject private var bearVM = RiveViewModel(fileName: "Bear")
    
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Tab Selector
                Picker("Demo Type", selection: $selectedTab) {
                    Text("Basic").tag(0)
                    Text("Interactive").tag(1)
                    Text("Character").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content Area
                TabView(selection: $selectedTab) {
                    BasicAnimationView(viewModel: basketballVM)
                        .tag(0)
                    
                    InteractiveAnimationView(viewModel: iconVM)
                        .tag(1)
                    
                    CharacterAnimationView(viewModel: bearVM)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle("Rive Demo")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Basic Animation View
struct BasicAnimationView: View {
    @ObservedObject var viewModel: RiveViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Basic Animation Playback")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This demonstrates simple Rive animation playback with automatic looping.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Rive Animation
            viewModel.view()
                .frame(width: 300, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 12) {
                InfoRow(label: "File", value: "basketball.riv")
                InfoRow(label: "Type", value: "Simple Animation")
                InfoRow(label: "Code", value: "~5 lines")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.1))
            )
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 30)
    }
}

// MARK: - Interactive Animation View
struct InteractiveAnimationView: View {
    @ObservedObject var viewModel: RiveViewModel
    @State private var tapCount = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Interactive State Machine")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Tap the animation to trigger state transitions and see the state machine in action.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Rive Animation with Interaction
            viewModel.view()
                .frame(width: 350, height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.1))
                )
//                .onTapGesture {
                    // Trigger state machine input
//                    viewModel.triggerInput("Trigger 1")
//                    tapCount += 1
//                    viewModel.triggerInput("start")
//                }
            
                Button("Start") {
                    viewModel.triggerInput("start", path: "New Artboard")
                }
            
            VStack(alignment: .leading, spacing: 12) {
                InfoRow(label: "File", value: "clean_icon_set.riv")
                InfoRow(label: "Type", value: "State Machine")
                InfoRow(label: "Input", value: "Trigger on Tap")
                InfoRow(label: "States", value: "Multiple Icon States")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.purple.opacity(0.1))
            )
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 30)
    }
}

// MARK: - Character Animation View
struct CharacterAnimationView: View {
    @ObservedObject var viewModel: RiveViewModel
    @State private var isPlaying = true
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Character Animation")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Complex character animation with multiple states and smooth transitions.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Rive Animation
            viewModel.view()
                .frame(width: 300, height: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.1))
                )
            
            // Playback Controls
            HStack(spacing: 20) {
                Button(action: {
                    if isPlaying {
                        viewModel.pause()
                    } else {
                        viewModel.play()
                    }
                    isPlaying.toggle()
                }) {
                    HStack {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        Text(isPlaying ? "Pause" : "Play")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    viewModel.stop()
                    viewModel.play()
                    isPlaying = true
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Reset")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .cornerRadius(10)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                InfoRow(label: "File", value: "Bear.riv")
                InfoRow(label: "Type", value: "Character Animation")
                InfoRow(label: "Size", value: "~35KB")
                InfoRow(label: "Features", value: "Multiple States")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.orange.opacity(0.1))
            )
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 30)
    }
}

// MARK: - Helper Views
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
