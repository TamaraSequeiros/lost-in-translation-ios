import SwiftUI

struct GameResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    let correctGuesses: Int
    let totalGuesses: Int
    
    var body: some View {
        ZStack {
            Color.indigo.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("Game Results")
                    .customFont(.title)
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    ResultRow(label: "Correct Guesses", value: correctGuesses)
                    ResultRow(label: "Wrong Guesses", value: totalGuesses - correctGuesses)
                    ResultRow(label: "Success Rate", value: "\(Int((Double(correctGuesses) / Double(totalGuesses)) * 100))%")
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Back to Main Menu")
                        .customFont(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 40)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct ResultRow: View {
    let label: String
    let value: Any
    
    var body: some View {
        HStack {
            Text(label)
                .customFont(.title)
            Spacer()
            Text("\(value)")
                .customFont(.title)
        }
        .foregroundColor(.white)
        .padding(.horizontal)
    }
} 