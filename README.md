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
renv::runTests()
```

## Further Ideas

* Reformat code and run test
* Implement CI/ (autorun of code styler, lintr, tests in Travis)
* Extract data directly from GBIF with [rgbif](https://docs.ropensci.org/rgbif/) package
* Inspect code with profviz and improve performance
* Implement selectize dropdown nested tree for species search
* Add button to clear selections

### Author

Yulia Iakovleva [@greenjune-ship-it](https://github.com/greenjune-ship-it)