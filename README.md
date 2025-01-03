# Movie App - README

## Overview

This is an iOS Movie App built using Swift and UIKit. The app displays a list of movies in a table view and their corresponding posters in a horizontally scrolling collection view. Users can search for movies using a search bar, and the filtered results will be displayed in the table view. Additionally, a page control at the bottom of the collection view indicates the current poster being displayed.

## Features

- Displays movie posters in a horizontally scrolling collection view.
- Lists movie names and thumbnails in a table view.
- Provides a search functionality to filter movies by name.
- Implements page control to indicate the currently visible movie poster.
- Dismisses the keyboard when tapping outside the text field.

## Components

### Models

#### `MovieDetails`

A struct representing the details of a movie.

```swift
definition struct MovieDetails {
    let movieName: String
    let movieImageName: String
}
```

### ViewController

#### Outlets

- `moviePosterCollectionView`: Displays the movie posters.
- `searchTextBox`: Text field for entering search queries.
- `movieList`: Table view for displaying movie names and thumbnails.
- `pageControle`: Page control indicating the current movie poster.

#### Properties

- `timer`: Optional timer for auto-scrolling (if needed).
- `currentCellIndex`: Tracks the current index of the visible collection view cell.
- `movieDetails`: Array containing all movie details.
- `filteredMovies`: Array containing movies filtered based on the search query.

#### Methods

1. **`initializeData`**
   Initializes the `movieDetails` array and sets the initial page control count.

2. **`setupCollectionView`**
   Configures the collection view layout and assigns its delegate and data source.

3. **`setupTableView`**
   Assigns the table view's delegate and data source.

4. **`setupSearchTextBox`**
   Configures the search text box and adds a target for the `.editingChanged` event.

5. **`setupDismissKeyboardGesture`**
   Adds a tap gesture recognizer to dismiss the keyboard when tapping outside the text field.

6. **`searchMovies`**
   Filters the `movieDetails` array based on the entered search query.

7. **`dismissKeyboard`**
   Dismisses the keyboard.

#### UICollectionView Delegate and Data Source

- **`collectionView(_:numberOfItemsInSection:)`**
  Returns the number of movie posters.

- **`collectionView(_:cellForItemAt:)`**
  Configures the collection view cell with the corresponding movie poster.

- **`collectionView(_:layout:sizeForItemAt:)`**
  Returns the size for each collection view cell.

#### UITableView Delegate and Data Source

- **`tableView(_:numberOfRowsInSection:)`**
  Returns the number of rows in the table view.

- **`tableView(_:cellForRowAt:)`**
  Configures the table view cell with the corresponding movie name and thumbnail.

#### UIScrollView Delegate

- **`scrollViewDidScroll(_:)`**
  Updates the page control's current page based on the collection view's scroll position.

### MovieDetailsCell

A custom table view cell displaying the movie's name and image.

## How to Run

1. Open the project in Xcode.
2. Connect a simulator or a physical device.
3. Build and run the app.

## Requirements

- iOS 13.0 or later
- Xcode 12.0 or later

## Customization

1. **Adding New Movies**
   To add new movies, update the `getDetails` method in `ViewController`.
   ```swift
   ```

definition func getDetails() -> [MovieDetails] {
return [
MovieDetails(movieName: "New Movie", movieImageName: "newImage")
]
}

````

2. **Adjusting Collection View Layout**
Modify the layout properties in the `setupCollectionView` method.
```swift
definition layout.scrollDirection = .horizontal
layout.minimumLineSpacing = 3
layout.minimumInteritemSpacing = 3
````

## Future Enhancements

- Implement auto-scrolling for the collection view.
- Add a details screen when a movie is selected.
- Improve UI/UX with animations and transitions.


