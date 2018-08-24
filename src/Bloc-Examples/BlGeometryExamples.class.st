Class {
	#name : #BlGeometryExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Basic'
}

{ #category : #'instance creation' }
BlGeometryExamples >> rectangle [
	<gtExample>

	^ BlRectangle extent: self rectangleExtent
]

{ #category : #'instance creation' }
BlGeometryExamples >> rectangleExtent [
	<gtExample>
	
	^ 300@200
]
