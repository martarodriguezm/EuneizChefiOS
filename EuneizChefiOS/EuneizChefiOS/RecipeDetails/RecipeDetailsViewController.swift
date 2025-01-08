//
//  RecipeDetailsViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//

import UIKit
import Alamofire

class RecipeDetailsViewController: UIViewController {
    
    var recipeId: String?
    var recipeDetails: RecipeDetail?
    
    
    @IBOutlet weak var ingredientsLabelText: UILabel!
    @IBOutlet weak var instructionsLabelText: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeAreaLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var youtubeLinkButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Strings
        ingredientsLabelText.text = String(localized: "ingredientsLabelText")
        instructionsLabelText.text = String(localized: "instructionsLabelText")
        
        if let recipeId = recipeId {
            print("Fetching details for recipeId: \(recipeId)") // Para depuración
            fetchRecipeDetails(id: recipeId)
        } else {
            print("recipeId is nil") // Depuración en caso de problema
        }
    }
        
    // Fetch the details of the recipe
    func fetchRecipeDetails(id: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        AF.request(urlString).responseDecodable(of: RecipeDetailResponse.self) { response in
            switch response.result {
            case .success(let data):
                guard let details = data.meals?.first else { return }
                self.recipeDetails = details
                DispatchQueue.main.async {
                    self.updateUI(with: details)
                }
            case .failure(let error):
                print("Error fetching recipe details: \(error)")
            }
        }
    }
    
    func updateUI(with recipeDetail: RecipeDetail) {
        recipeNameLabel.text = recipeDetail.strMeal
        recipeAreaLabel.text = recipeDetail.strArea
        recipeCategoryLabel.text = recipeDetail.strCategory
        
        // Set image
        recipeImageView.Image(from: recipeDetail.strMealThumb!)
        
        // Set ingredients
        var ingredientsText = ""
        for (index, ingredient) in recipeDetail.ingredients.enumerated() {
            if !ingredient.isEmpty {
                ingredientsText += "\(ingredient) - \(recipeDetail.measures[index])\n"
            }
        }
        ingredientsTextView.text = ingredientsText
        
        // Set instructions
        instructionsTextView.text = recipeDetail.strInstructions
        
        // Set YouTube link button
        if let youtubeLink = recipeDetail.strYoutube {
            youtubeLinkButton.isHidden = false
            youtubeLinkButton.addTarget(self, action: #selector(openYouTubeLink), for: .touchUpInside)
        } else {
            youtubeLinkButton.isHidden = true
        }
    }
    
    @objc func openYouTubeLink() {
        if let youtubeLink = recipeDetails?.strYoutube, let url = URL(string: youtubeLink) {
            UIApplication.shared.open(url)
        }
    }
}
// Extensión para UIImageView para cargar imágenes de manera asincrónica
extension UIImageView {
    func Image(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Realiza la carga de la imagen en un hilo de fondo
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image // Asigna la imagen al UIImageView en el hilo principal
                }
            }
        }
    }
}
