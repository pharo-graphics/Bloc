"
I am a BlLayout used to allow the BlElement to adopt the correct size to display its children.
"
Class {
	#name : #BlSvgGroupLayout,
	#superclass : #BlBasicLayout,
	#category : 'Bloc-SVG-Element'
}

{ #category : #layout }
BlSvgGroupLayout >> layout: anElement in: aRectangle [
	| visualBounds |
	
	super layout: anElement in: aRectangle.
	
	anElement hasChildren
		ifFalse: [ ^ self ].
	
	visualBounds := (anElement children first localBoundsToParent: (BlBounds fromRectangle: anElement children first visualBounds)).
	anElement children do: [ :child |	visualBounds merge: (child localBoundsToParent: (BlBounds fromRectangle: child visualBounds)) ].

	anElement size: (visualBounds corner max: 0@0)
]
