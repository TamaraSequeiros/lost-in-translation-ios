import Speech
import AVFoundation

class SpeechRecognizer: ObservableObject {
    @Published var isRecording = false
    @Published var text = ""
    
    private var audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    func startRecording() {
        guard !isRecording else { return }
        
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            guard status == .authorized else { return }
            
            self?.recordAndRecognizeSpeech()
        }
    }
    
    func stopRecording() {
        isRecording = false
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
    
    private func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        let request = SFSpeechAudioBufferRecognitionRequest()
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        do {
            try audioEngine.start()
            isRecording = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: request) { [weak self] result, error in
                guard let result = result else { return }
                self?.text = result.bestTranscription.formattedString
            }
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
} 