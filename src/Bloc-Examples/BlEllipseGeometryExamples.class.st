Class {
	#name : #BlEllipseGeometryExamples,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #accessing }
BlEllipseGeometryExamples >> default [
	<gtExample>
	| anEllipse |
	
	anEllipse := BlEllipseGeometry new.
	
	self assert: anEllipse extent equals: 150@100.
	
	^ anEllipse
]
