Class {
	#name : #BlExampleInfiniteForGeometryLinearNode,
	#superclass : #BlExampleInfiniteForGeometryNode,
	#instVars : [
		'shouldHaveLine'
	],
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #'api - instantiation' }
BlExampleInfiniteForGeometryLinearNode >> create [
	| aFrame theChildren |
	
	aFrame := BlElement new.
	aFrame layout: BlLinearLayout horizontal.
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
