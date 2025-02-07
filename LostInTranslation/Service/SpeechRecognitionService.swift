import Speech
import AVFoundation

class SpeechRecognitionService {
    private var audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?
    
    func configureSpeechRecognizer(for language: Language) {
        let locale = Locale(identifier: language.localeIdentifier)
        speechRecognizer = SFSpeechRecognizer(locale: locale)
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            completion(status == .authorized)
        }
    }
    
    func startRecording(onRecognizedText: @escaping (String) -> Void) {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        let request = SFSpeechAudioBufferRecognitionRequest()
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        
        do {
            try audioEngine.start()
            
            recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, error in
                guard let result = result else { return }
                onRecognizedText(result.bestTranscription.formattedString)
            }
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
} 