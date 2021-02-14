"
I have been automatically converted and probably manually tweaked from BlEllipseGeometryExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlEllipseGeometryTest,
	#superclass : #BlGeometryTest,
	#category : #'Bloc-UnitedTests-Geometry'
}

{ #category : #metadata }
BlEllipseGeometryTest >> originClassName [
	"This test was generated from..."
	^ 'BlEllipseGeometryExamples'
]

{ #category : #tests }
BlEllipseGeometryTest >> testDefault [
	<gtExample>
	| anEllipse |
	anEllipse := BlEllipseGeometry new.
	self assert: anEllipse extent equals: 150 @ 100.
	^ anEllipse
]
