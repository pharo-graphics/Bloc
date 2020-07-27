Class {
	#name : #BlEmptyVisuals,
	#superclass : #BlElementVisuals,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlEmptyVisuals class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlEmptyVisuals class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlEmptyVisuals >> background [
	^ self defaultBackground
]

{ #category : #accessing }
BlEmptyVisuals >> background: aBlBackground [
	"Change the background and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new background: aBlBackground
]

{ #category : #accessing }
BlEmptyVisuals >> border [
	^ self defaultBorder
]

{ #category : #accessing }
BlEmptyVisuals >> border: aBlBorder [
	"Change the border and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new border: aBlBorder
]

{ #category : #accessing }
BlEmptyVisuals >> clipChildren [
	^ self defaultClipChildren
]

{ #category : #accessing }
BlEmptyVisuals >> clipChildren: aBoolean [
	"Change if children should be clipped and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new clipChildren: aBoolean
]

{ #category : #accessing }
BlEmptyVisuals >> compositingMode [
	^ self defaultCompositingMode
]

{ #category : #accessing }
BlEmptyVisuals >> compositingMode: aBlCompositingMode [
	"Change the compositing mode and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new compositingMode: aBlCompositingMode
]

{ #category : #accessing }
BlEmptyVisuals >> effect [
	^ self defaultEffect
]

{ #category : #accessing }
BlEmptyVisuals >> effect: aBlElementEffect [
	"Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new effect: aBlElementEffect
]

{ #category : #accessing }
BlEmptyVisuals >> elevation [
	^ self defaultElevation
]

{ #category : #accessing }
BlEmptyVisuals >> elevation: aBlElevation [
	"Change the elevation and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new elevation: aBlElevation
]

{ #category : #accessing }
BlEmptyVisuals >> focusability [
	^ self defaultFocusability
]

{ #category : #accessing }
BlEmptyVisuals >> focusability: aBlFocusability [
	"Change the focusability and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new focusability: aBlFocusability
]

{ #category : #accessing }
BlEmptyVisuals >> focused [
	^ self defaultFocused
]

{ #category : #accessing }
BlEmptyVisuals >> focused: aBoolean [
	"Change focused state and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new focused: aBoolean
]

{ #category : #accessing }
BlEmptyVisuals >> geometry [
	^ self defaultGeometry
]

{ #category : #accessing }
BlEmptyVisuals >> geometry: aBlElementGeometry [
	"Change the geometry and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new geometry: aBlElementGeometry
]

{ #category : #accessing }
BlEmptyVisuals >> mouseCursor [
	^ self defaultMouseCursor
]

{ #category : #accessing }
BlEmptyVisuals >> mouseCursor: aBlCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new mouseCursor: aBlCursor
]

{ #category : #accessing }
BlEmptyVisuals >> opacity [
	^ self defaultOpacity
]

{ #category : #accessing }
BlEmptyVisuals >> opacity: aNumber [
	"Change the opacity and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new opacity: aNumber
]

{ #category : #accessing }
BlEmptyVisuals >> outskirts [
	^ self defaultOutskirts
]

{ #category : #accessing }
BlEmptyVisuals >> outskirts: aBlOutskirts [
	"Change the outskirts and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new outskirts: aBlOutskirts
]

{ #category : #accessing }
BlEmptyVisuals >> visibility [
	^ self defaultVisibility
]

{ #category : #accessing }
BlEmptyVisuals >> visibility: aBlVisibility [
	"Change the visibility and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlConcreteVisuals new visibility: aBlVisibility
]
