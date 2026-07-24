### Parsing Flow

```mermaid
flowchart LR
A[JSON] --> B(DTO) --> C(Mapper) --> D(Domain Entity)
```

### Debounce Flow

```mermaid

flowchart TD
    A[User types] --> B[Search event]
    B --> C[Start debounce timer]
    C --> D{New event during 350 ms?}
    D -->|Yes| E[Restart timer]
    E --> C
    D -->|No| F[Call repository]
    F --> G[Emit result]
```

### Restartable Flow

```mermaid
flowchart TD
A[User types a search query]
B[Search event sent to Bloc]
C[Debounce waits 350ms]
D{New search event arrives?}
E[Restart debounce timer]
F[Call repository]
G{Another search starts while a request is pending?}
a[Emit success with current results]
b[Cancel previous handler subscription]
c[Start latest repository request]
d(Emit a success with the latest results)
A-->B-->C
C-->D
D-->|Yes|E -->C
D-->|No|F
F -->G
G -->|No|a
G -->|Yes|b
b --> c
c --> d
```

## Folder Structure

```text
lib/
├── core/
│   ├── di/
│   ├── network/
│   ├── navigation/
│   ├── error/
│   └── widgets/
│
└── ui/
    └── features/
        └── breweries_list/
            ├── data/
            │   ├── datasources/
            │   ├── dtos/
            │   ├── mappers/
            │   └── repositories/
            │
            ├── domain/
            │   ├── entities/
            │   └── repositories/
            │
            └── presentation/
                ├── breweries_list/
                └── brewery_detail/
```

The project is organized by feature, with Data, Domain and Presentation responsibilities separated inside the brewery feature. Shared infrastructure and reusable widgets live in core.
