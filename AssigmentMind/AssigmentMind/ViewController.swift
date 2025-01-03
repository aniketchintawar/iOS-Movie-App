
import UIKit

// MARK: - Movie Details Model
struct MovieDetails {
    let movieName: String
    let movieImageName: String
}

class ViewController: UIViewController, UITextFieldDelegate {

// MARK: - Outlets
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    @IBOutlet weak var searchTextBox: UITextField!
    @IBOutlet weak var movieList: UITableView!
    @IBOutlet weak var pageControle: UIPageControl!

// MARK: - Properties
    var timer: Timer?
    var currentCellIndex: Int = 0
    var movieDetails: [MovieDetails] = []
    var filteredMovies: [MovieDetails] = []

// MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeData()
        setupCollectionView()
        setupTableView()
        setupSearchTextBox()
        setupDismissKeyboardGesture()

    }

// MARK: - Initial Setup Methods

    private func initializeData() {
        movieDetails = getDetails()
        filteredMovies = movieDetails // Initially show all movies
        pageControle.numberOfPages = movieDetails.count
    }

    private func setupCollectionView() {
        moviePosterCollectionView.delegate = self
        moviePosterCollectionView.dataSource = self
        moviePosterCollectionView.isPagingEnabled = true
        moviePosterCollectionView.showsHorizontalScrollIndicator = false

        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 3 // Space between items
                layout.minimumInteritemSpacing = 3
                moviePosterCollectionView.collectionViewLayout = layout
        
        // Assign scroll view delegate
            //moviePosterCollectionView.delegate = self
    }


    private func setupTableView() {
        movieList.dataSource = self
        movieList.delegate = self
    }

    private func setupSearchTextBox() {
        searchTextBox.delegate = self
        searchTextBox.addTarget(self, action: #selector(searchMovies), for: .editingChanged)
    }


    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Data Source Methods

    func getDetails() -> [MovieDetails] {
        return [
            MovieDetails(movieName: "JOKER", movieImageName: "image23"),
            MovieDetails(movieName: "ADUHRA", movieImageName: "images2"),
            MovieDetails(movieName: "AARYA", movieImageName: "images3"),
            MovieDetails(movieName: "INCOGNITO", movieImageName: "images4"),
            MovieDetails(movieName: "MASTER TWIST", movieImageName: "images5")
        ]
    }

// MARK: - Methods



    @objc func searchMovies() {
        guard let searchText = searchTextBox.text?.lowercased(), !searchText.isEmpty else {
            filteredMovies = movieDetails // Show all movies if search text is empty
            movieList.reloadData()
            return
        }
        
        filteredMovies = movieDetails.filter { $0.movieName.lowercased().contains(searchText) }
        movieList.reloadData()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }

// MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviePosterCollectionView

        cell.movieImgPoster.image = UIImage(named: movieDetails[indexPath.row].movieImageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 3 // Full width with padding
        let height = width * 0.5 // Adjust height as needed
        return CGSize(width: width, height: height)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieDetailsCell
        cell.movieName.text = filteredMovies[indexPath.row].movieName
        cell.movieImage.image = UIImage(named: filteredMovies[indexPath.row].movieImageName)
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == moviePosterCollectionView {
            let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
            pageControle.currentPage = pageIndex
        }
    }
}

// MARK: - MovieDetailsCell
class MovieDetailsCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
}

