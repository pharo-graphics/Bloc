initialization
initialize
	super initialize.
	formBlock := [ | object presentationSelector composite morph |
	object := self path asFileReference.
	presentationSelector := #gtInspectorItemsIn:.
	composite := GLMCompositePresentation new.
	object perform: presentationSelector with: composite.
	composite presentations last title: nil.
	composite startOn: object.
	morph := composite renderGlamorouslyOn: GLMRenderer subclasses first new.
	morph extent: self extent.
	morph imageForm ]