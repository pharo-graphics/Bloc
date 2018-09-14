Class {
	#name : #BlExampleInfiniteForGeometryFrameNode,
	#superclass : #BlExampleInfiniteForGeometryNode,
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #'api - instantiation' }
BlExampleInfiniteForGeometryFrameNode >> create [
	| aFrame theChildren |
	
	aFrame := BlElement new.
	aFrame layout: BlFrameLayout new.
	aFrame background: (Color gray alpha: 0.1).
	aFrame padding: (BlInsets all: 10).
	aFrame constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	theChildren := self nodes collect: #asElement.
	theChildren do: #removeFromParent.
	aFrame addChildren: theChildren.
	
	^ aFrame
]
