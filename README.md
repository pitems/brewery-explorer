# Brewery Explorer

A Flutter application built as a technical challenge using **Clean Architecture**, **Bloc** and **Dependency Injection**.

The application displays breweries from the Open Brewery DB API, supports searching, pagination and brewery details while following a layered architecture focused on maintainability and testability.

---

## How to run

### Requirements

- Flutter 3.44.6
- Dart SDK
- FVM (optional)

### Install dependencies

```bash
flutter pub get
```

### Generate code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run

```bash
flutter run
```

### Run tests

```bash
flutter test
```

---

## Completed

- Brewery list
- Brewery detail screen
- Infinite scroll pagination
- Brewery search
- Debounced search using 'bloc_concurrency'
- Retry mechanism
- Error handling
- Clean Architecture
- Dependency Injection using Injectable/GetIt

## Unit tests

- DTO
- Mapper
- Repository
- Bloc

---

## Intentionally left out

- Offline support
- Mapbox integration
- Distance sorting using Geolocator

These were intentionally left out to focus on delivering a polished implementation of the core application requirements together with the debounce search bonus.

---

## Trade-Offs

Several architectural decisions were made to keep the project simple while
remaining scalable:

- Separate DTOs from Domain Entities.
- Repository layer responsible for mapping data.
- Dedicated Detail Entity instead of reusing the list entity.
- Search and pagination handled by the same Bloc to avoid duplicated logic.
- Focused on unit testing rather than widget testing due to the challenge scope.

---

## Future Improvements

Given additional development time, the next improvments would be:

- Offline cache
- Mapbox visualization
- Brewery distance calculation
- Widget Tests
- Animations and UI polish

---

## Notes

The search implementation uses **bloc_concurrency** with a custom
`debounceRestartable` transformer to ensure only the latest search result
updates the UI while avoiding unnecessary network requests.

---

## Documentation

Additional project documentation can be found inside the '/docs' folder

- Architecture
- Project Structure
- State management
