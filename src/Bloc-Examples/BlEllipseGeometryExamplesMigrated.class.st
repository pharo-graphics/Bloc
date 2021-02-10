Class {
	#name : #BlEllipseGeometryExamplesMigrated,
	#superclass : #BlGeometryExamplesMigrated,
	#category : #'Bloc-Examples-DocumentationMigrated'
}

{ #category : #accessing }
BlEllipseGeometryExamplesMigrated >> default [
	<gtExample>
	| anEllipse |
	
	anEllipse := BlEllipseGeometry new.
	
	self assert: anEllipse extent equals: 150@100.
	
	^ anEllipse
]
