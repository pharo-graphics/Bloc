# CHANGELOG

## [Unreleased]
### Added
 - New BlTextElement
 - New BlTransformation
 - First version of a GTK Host (to improve the Host strategy)
 
### Changed

## [v0.12] - 2017-01-27

### Added

 - Management of infinite scrolling
 - SDL Host (without the intermediary of OSWindow)
 - Focus/key navigation (Tab and Shift+Tab)
 - Support for retina screen
 - SDL2 <-> Skia renderer
 - Blur and Overlay effects

### Changed

 - Style and Theme stuff moved to Brick
 - Key binding api and key event management improvement
 - SDL Host is used by default
 - No more direct dependencies between BlUniverse and Hosts
 - Renaming of "extent:" to "size:" and "resize:" to "extent:"
 - No more direct dependencies between Bloc's core package and Sparta
 - Children management improvement
 - Path rendering optimization
 - Border rendering improvement
 - Explicit transparent paint and border
 - Layout pass improvement
 - Animation improvement
 - Tests and Examples updates

## [v0.11] - 2016-11-11

### Major Features
 - End of Athens support
 - Support for MS Windows (libMoz2D binary)
 - BlText with SpartaText backend
 - Static linear and radial GradientPaints
 - BoxShadow effect based on Sparta filters
 - Improvement of BlAnimation
 - Drag & Drop basis
