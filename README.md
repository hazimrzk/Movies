# Fave Technical Assignment

## Introduction
This assignment helps us better understand your ability to solve problems and fulfil task requirements with technical solutions. We would like to get an impression of how you write code in the real world. We will be evaluating your communication skills, development capabilities, and your interpretation of what good, clean, production-ready code should look like.

## Scenario
Cinema operators such as Cathay are one of the most popular merchants we have in Fave. We want to build an app to help our users discover movies easily.

## Requirements
Create a standalone movie app / mobile web(responsive UI) with the following screens:

## Home screen with a list of available movies

- Ordered by release date (default), alphabetical, rating - can use dropdown 
- Pull to refresh
- Load when scrolled to the bottom
- Each movie to include:
  - Poster/Backdrop image
  - Title
  - Popularity
    
## Detail screen
Movie details should have the following:
- Synopsis
- Genres
- Language
- Duration
- Book the movie (simulate the opening of this [link](https://www.cathaycineplexes.com.sg/) in a web view)

## Frontend Design
It is up to you to design the UI. Simple is good.

## Backend
Use the API from [TMDb](https://developers.themoviedb.org/3/getting-started/introduction) as your data source. You can use our API Key: `328c283cd27bd1877d9080ccb1604c91`
  
### Sample requests

**Listing**

```
http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=popularity.asc&page=1
```

**Detail**

```
http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9080ccb1604c91
```

## Technical requirements:

| iOS | Android | Web (ReactJS) | Web (Vanilla JS) |
| ---- | ------ | ------------- | ---------------- |
| Minimum Swift 4.0 | Kotlin or Java | React based framework (ReactJS, create-react-app, etc) | Use normal / no-framework JS |
| Usage of RxSwift + MVVM | RxJava / RxKotlin / Coroutine / Flow | CSS or SASS | CSS or SASS |
| Dependency Injection | MVVM / VIPER / MVI / Clean Architecture | Context API & hooks | State to store value & support 2 way data binding |
| | Dependency Injection - Dagger / Koin / Hilt | Use correct routes, param & URL (include navigation & not found routes) | Use correct routes, param & URL (include navigation & not found routes) |
| | Data Binding / View Binding | Knowledge & experience using typescript is a must | |
| | XML layout / Jetpack Compose | | |

We expect unit tests for the main functionalities. You can use third-party libraries to achieve unit testing.

## Code Repo
Please use this repo for your commits.

## Evaluation Criteria
- Clean, readable, maintainable, and performant code (*this includes but is not limited to* no unused code, logger, debugger, warning, error, memory leak, infinite loop, jank/lag)
- Clear documentation that describes your assumptions and design considerations. You can create a new `.md` in this repo. Example: `DOCUMENTATION.md`
- Unit Tests will be evaluated

That’s the end of the assignment, we hope you have fun!
Looking forward to your submission.
