Class {
	#name : #BlExampleInfiniteForGeometryElement,
	#superclass : #BlInfiniteElement,
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> defaultDataSource [
	^ BlExampleInfiniteForGeometryDataSource new
]

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]
