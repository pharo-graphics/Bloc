"
TODO needs some work to use it in dropdown to reveal the same toggle
"
Class {
	#name : #BlClipOutGeometryEffect,
	#superclass : #BlClipOutEffect,
	#instVars : [
		'geometry',
		'offset'
	],
	#category : #'Bloc-Effect'
}

{ #category : #example }
BlClipOutGeometryEffect class >> example [
	<gtExample>
	| element elementWithBorder container |
	element := BlElement new.
	element background: (Color green darker alpha: 1).
	element geometry: BlEllipse new.
	element size: 200 @ 100.
	element when: BlClickEvent do: [ self inform: 'Click' ].
	element
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	element.
	element forceLayout.
	elementWithBorder := BlElement new.
	elementWithBorder background: (Color blue alpha: 1).
	elementWithBorder geometry: BlEllipse new.
	elementWithBorder
		border: (BlBorder paint: (Color red alpha: 1) width: 25).
	elementWithBorder size: 250 @ 150.
	elementWithBorder
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	elementWithBorder outskirts: BlOutskirts inside.
	elementWithBorder
		effect:
			(BlClipOutGeometryEffect new
				geometry: element geometry;
				offset: 25 asPoint).
	elementWithBorder preventMouseEvents.
	elementWithBorder.
	container := BlElement new.
	container margin: (BlInsets all: 30).
	container padding: (BlInsets all: 30).
	container layout: BlFrameLayout new.
	container
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	container
		addChildren:
			{element.
			elementWithBorder}.
	^ container
]

{ #category : #accessing }
BlClipOutGeometryEffect >> geometry [
	^ geometry
]

{ #category : #accessing }
BlClipOutGeometryEffect >> geometry: anObject [
	geometry := anObject
]

{ #category : #initialization }
BlClipOutGeometryEffect >> initialize [
	super initialize.
	
	geometry := (0@0 extent: 0@0)
]

{ #category : #accessing }
BlClipOutGeometryEffect >> offset: aPoint [
	offset := aPoint
]

{ #category : #accessing }
BlClipOutGeometryEffect >> offsetFor: anElement [
	^ offset
]
