# flutter_gen

A code generator intended to test flutter web scaling.

### Overview
This project is intended to assist with generating any given number of widgets to help with identifying scale issues when using Flutter for Web.

## Getting Started

### Running the application

- Build Step: `make build`
- Run Step: `fluttergen <Widget COunt>` 

### Current progress
A very rudimentary code generator has been implemented. It produces a new Flutter project called `scale_app` in the directory where it is run. Since this isn't as much a Flutter project as it is a dart one, that generates Flutter code.

### TODO
- Unit testing
- Build UI to interactively generate widgets.
