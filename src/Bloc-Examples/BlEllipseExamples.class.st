Class {
	#name : #BlEllipseExamples,
	#superclass : #BlGeometryExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #accessing }
BlEllipseExamples >> default [
	<gtExample>
	| anEllipse |
	
	anEllipse := BlEllipse new.
	
	self assert: anEllipse extent equals: 150@100.
	
	^ anEllipse
]
