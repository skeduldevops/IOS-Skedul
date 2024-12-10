import Foundation

class APIService {
    static let shared = APIService()

    func fetchPartners(subcategory: String?, completion: @escaping (Result<[Partner], Error>) -> Void) {
        guard let url = URL(string: "https://skedulapp.bubbleapps.io/api/1.1/wf/get_service") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer f7414fff437f22769d5cd86d2a8c3456", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let partners = try JSONDecoder().decode([Partner].self, from: data)
                completion(.success(partners))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (URL?) -> Void) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageDirectory = documentsDirectory.appendingPathComponent("Images")
        
        if !fileManager.fileExists(atPath: imageDirectory.path) {
            do {
                try fileManager.createDirectory(at: imageDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error)")
                completion(nil)
                return
            }
        }
        
        let imageName = url.lastPathComponent
        let imagePath = imageDirectory.appendingPathComponent(imageName)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    try data.write(to: imagePath)
                    completion(imagePath)
                } catch {
                    print("Error saving image: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
