# Biodiversity Explorer

## About Project

Biodiversity Explorer visualizes observed species on the map. Dataset comes
from [Global Biodiversity Information Facility](https://www.gbif.org/), observations from Poland available by 8 March
2020 are presented.

## Getting Started

### Restore packages

```
renv::restore()
```

### Run tests

```
shiny::runTests()
```

## Further Ideas

* Add tab with displayed data
* Implement CI/CD; autorun of code styler, lintr, tests (gitHub actions or / and Travis)
* Extract data directly from GBIF with [rgbif](https://docs.ropensci.org/rgbif/) package or create custom SQL database
  and interface for usage
* Inspect code with profviz and improve performance
* Implement selectize dropdown nested tree for scientific species search
* Add button to clear selections
* Replace constant map size by fit to screen size

### Author

Yulia Iakovleva [@greenjune-ship-it](https://github.com/greenjune-ship-it)