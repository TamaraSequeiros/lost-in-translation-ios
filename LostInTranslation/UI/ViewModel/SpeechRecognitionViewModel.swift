import Foundation

class SpeechRecognitionViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var text = ""
    
    private let service: SpeechRecognitionService
    private let settingsManager: SettingsManager
    
    init(service: SpeechRecognitionService = SpeechRecognitionService(),
         settingsManager: SettingsManager = .shared) {
        self.service = service
        self.settingsManager = settingsManager
        
        if let settings = settingsManager.loadGameSettings() {
            service.configureSpeechRecognizer(for: settings.language)
        }
    }
    
    func startRecording() {
        guard !isRecording else { return }
        
        service.requestAuthorization { [weak self] isAuthorized in
            guard isAuthorized else { return }
            
            self?.isRecording = true
            self?.service.startRecording { text in
                DispatchQueue.main.async {
                    self?.text = text
                }
            }
        }
    }
    
    func stopRecording() {
        isRecording = false
        service.stopRecording()
    }
} 