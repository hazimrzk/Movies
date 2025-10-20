# Movies App Documentation

## Project Overview

This iOS application is a movie discovery app that allows users to browse now playing movies, explore different genres, search for specific movies, and view detailed information about each film. The app integrates with The Movie Database (TMDB) API and provides a modern, user-friendly interface built with SwiftUI.

## Architecture & Design Patterns

### MVVM Architecture

The app follows the Model-View-ViewModel (MVVM) pattern to ensure clean separation of concerns:

- **Models**: Data structures representing API responses ([`Listing`](Movies/Movies/Home/HomeModel.swift), [`MovieDetails`](Movies/Movies/MovieDetails/MovieDetailsModel.swift), [`MovieCredits`](Movies/Movies/MovieDetails/MovieDetailsModel.swift))
- **Views**: SwiftUI views for UI presentation ([`HomeView`](Movies/Movies/Home/HomeView.swift), [`MovieDetailsView`](Movies/Movies/MovieDetails/MovieDetailsView.swift), [`DiscoverView`](Movies/Movies/Discover/DiscoverView.swift))
- **ViewModels**: Business logic and state management ([`HomeViewModel`](Movies/Movies/Home/HomeViewModel.swift), [`MovieDetailsViewModel`](Movies/Movies/MovieDetails/MovieDetailsViewModel.swift), [`DiscoverViewModel`](Movies/Movies/Discover/DiscoverViewModel.swift))

### Dependency Injection

The app implements dependency injection through protocol-based networking:

- [`NetworkServiceProtocol`](Movies/Movies/Services/NetworkService.swift) defines the networking contract
- [`TMDBService`](Movies/Movies/Services/TMDBService.swift) accepts any implementation of `NetworkServiceProtocol`
- [`MockNetworkService`](Movies/MoviesTests/Mocks/MockNetworkService.swift) is used for testing

## Key Features & Implementation

### 1. Home Screen - Now Playing Movies

- **Location**: [`HomeView`](Movies/Movies/Home/HomeView.swift) & [`HomeViewModel`](Movies/Movies/Home/HomeViewModel.swift)
- **Features**:
  - Pull-to-refresh functionality
  - Infinite scrolling with pagination
  - Sort by date, title, or rating
  - Toggle between grid and list view

### 2. Movie Details Screen

- **Location**: [`MovieDetailsView`](Movies/Movies/MovieDetails/MovieDetailsView.swift) & [`MovieDetailsViewModel`](Movies/Movies/MovieDetails/MovieDetailsViewModel.swift)
- **Features**:
  - Movie synopsis, genres, language, and duration
  - Cast and crew information
  - Star rating display
  - Book movie functionality (opens Cathay Cineplexes website)

### 3. Genre Discovery

- **Location**: [`DiscoverView`](Movies/Movies/Discover/DiscoverView.swift) & [`DiscoverViewModel`](Movies/Movies/Discover/DiscoverViewModel.swift)
- **Features**:
  - Browse movies by genre (Action, Romance, Animation, Horror, Comedy)
  - Horizontal scrolling lists for each genre

### 4. Search Functionality

- **Location**: [`SearchResultsView`](Movies/Movies/SearchResults/SearchResultsView.swift) & [`SearchResultsViewModel`](Movies/Movies/SearchResults/SearchResultsViewModel.swift)
- **Features**:
  - Search movies by title
  - Real-time search results

## Technical Implementation Details

### Networking Layer

The app uses a protocol-based networking architecture:

```swift
protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: TMDBEndpoint, responseType: T.Type) async throws -> T
}
```

which then integrates with TMDb API v3:

- Base URL: https://api.themoviedb.org/3
- Authentication: Bearer token
- Endpoints used:
  - `"/movie/now_playing"` - Current movies
  - `"/movie/{id}"` - Movie details
  - `"/movie/{id}/credits"` - Cast and crew
  - `"/discover/movie"` - Genre-based discovery
  - `"/search/movie"` - Search functionality

### Key Components

- [`NetworkService`](Movies/Movies/Services/NetworkService.swift) Production implementation using URLSession
- [`TMDBEndpoint`](Movies/Movies/Services/TMDBService.swift) Enum defining API endpoints
- [`TMDBService`](Movies/Movies/Services/TMDBService.swift) High-level service for movie-related operations

### Error Handling

Grouped error types for error handling:

```swift
enum TMDBError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
```

### Async/Await Integration

All network operations use Swift's modern concurrency:

- ViewModels marked with @MainActor for UI updates
- Async functions in service layer
- Proper error propagation

### UI Components

Modular, reusable SwiftUI components, to supplement page-based Views:

- [`MovieListTileView`](Movies/Movies/Components/MovieList/MovieListTileView.swift): Grid view representation
- [`MovieListListView`](Movies/Movies/Components/MovieList/MovieListListView.swift): List view representation
- [`PosterThumbnailView`](Movies/Movies/Components/MovieList/PosterThumbnailView.swift): Async image loading with fallbacks
- [`BottomButtonBarView`](Movies/Movies/Components/BottomButtonBar/BottomButtonBarView.swift): Action buttons with glass effect

## Testing Strategy

Unit Tests
Comprehensive test coverage for core functionality:

### Service Layer Tests

- Tested all types of data request with different outcome / error handling
- All types of data requests: Tested all implemented API endpoints (`GetNowPlaying`, `GetDetails`, `GetCredits`, `.GetListingsByGenre`, `GetListingsByPhrase`)
- All types of outcomes: `Success`, `InvalidData`, `InvalidResponse`

### Utility Tests

- Added test cases for utility functions used
- URL encoding functionality: Considered edge cases and special characters

### Mock Implementation:

- `MockNetworkService`: Enables isolated testing without network dependencies
- Tests use realistic JSON responses that match TMDb API structure, ensuring compatibility and proper parsing.

## Design Decisions & Assumptions

### SwiftUI Over UIKit

- **Decision**: Used SwiftUI for the entire interface
- **Rationale**: Modern, declarative UI framework that provides excellent integration with MVVM and async/await

### Protocol-Based Networking

- **Decision**: Abstracted networking behind NetworkServiceProtocol
- **Rationale**: Enables easy testing and potential future service swapping

### Pagination Strategy

- **Decision**: Implemented infinite scrolling with page-based loading
- **Rationale**: Better performance and user experience for large datasets

### API Key Management

- **Current State**: API key is embedded in code. For assessment use-case, this is safe. The README.md also store the API key.
- **Production Consideration**: Should be moved to secure configuration/environment variables. Will implement in future.

## Performance Considerations

### Lazy Loading

- Used LazyVGrid and LazyVStack for efficient memory usage
- Images loaded asynchronously with AsyncImage

### State Management

- ViewModels use @Published properties for reactive UI updates
- Minimal state duplication across the app

## Future Enhancements

### User Preferences

- Favorite movies functionality (UI placeholder already present)
- Viewing history tracking

### Enhanced Search

- Filter options (year, rating, genre)
- Search suggestions

### API Key Management

- Store API Keys securely
- Remove any hardcoded keys written in source code

## Build & Run Instructions

1. Open Movies.xcodeproj in Xcode
2. Select target device/simulator
3. Build and run the project
4. For testing: ⌘+U to run unit tests

## Dependencies

- **SwiftUI**: UI framework, with Swift version 5
- **Foundation**: Core functionality
- **XCTest**: Unit testing framework
- **WebKit**: For booking webview functionality
- **Optional**: iOS version 26.0+, for more uniform UI design. The UI elements of this project are created with Liquid Glass design language in mind.

## Conclusion

This Movies app demonstrates clean architecture principles, modern iOS development practices, and comprehensive testing. The modular design ensures maintainability and extensibility while providing a smooth user experience for movie discovery and exploration.
