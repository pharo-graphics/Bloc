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

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> initialize [
	super initialize.
	
	self background: (Color gray alpha: 0.05)
]
