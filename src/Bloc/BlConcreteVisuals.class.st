Class {
	#name : #BlConcreteVisuals,
	#superclass : #BlElementVisuals,
	#instVars : [
		'geometry',
		'border',
		'background',
		'outskirts',
		'effect',
		'visibility',
		'opacity',
		'clipChildren',
		'compositingMode',
		'focusability',
		'elevation',
		'focused',
		'mouseCursor'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlConcreteVisuals >> background [
	^ background ifNil: [ self defaultBackground ]
]

{ #category : #accessing }
BlConcreteVisuals >> background: aBlBackground [
	"Change the background and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	background := aBlBackground
]

{ #category : #accessing }
BlConcreteVisuals >> border [
	^ border ifNil: [ self defaultBorder ]
]

{ #category : #accessing }
BlConcreteVisuals >> border: aBlBorder [
	"Change the border and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	border := aBlBorder
]

{ #category : #accessing }
BlConcreteVisuals >> clipChildren [
	^ clipChildren ifNil: [ self defaultClipChildren ]
]

{ #category : #accessing }
BlConcreteVisuals >> clipChildren: aBoolean [
	"Change if children should be clipped and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	clipChildren := aBoolean
]

{ #category : #accessing }
BlConcreteVisuals >> compositingMode [
	^ compositingMode ifNil: [ self defaultCompositingMode ]
]

{ #category : #accessing }
BlConcreteVisuals >> compositingMode: aBlCompositingMode [
	"Change the compositing mode and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	compositingMode := aBlCompositingMode
]

{ #category : #accessing }
BlConcreteVisuals >> effect [
	^ effect ifNil: [ self defaultEffect ]
]

{ #category : #accessing }
BlConcreteVisuals >> effect: aBlElementEffect [
	"Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	effect := aBlElementEffect
]

{ #category : #accessing }
BlConcreteVisuals >> elevation [
	^ elevation ifNil: [ self defaultElevation ]
]

{ #category : #accessing }
BlConcreteVisuals >> elevation: aBlElevation [
	"Change the elevation and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	elevation := aBlElevation
]

{ #category : #accessing }
BlConcreteVisuals >> focusability [
	^ focusability ifNil: [ self defaultFocusability ]
]

{ #category : #accessing }
BlConcreteVisuals >> focusability: aBlFocusability [
	"Change the focusability and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	focusability := aBlFocusability
]

{ #category : #accessing }
BlConcreteVisuals >> focused [
	^ focused ifNil: [ self defaultFocused ]
]

{ #category : #accessing }
BlConcreteVisuals >> focused: aBoolean [
	"Change focused state and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	focused := aBoolean
]

{ #category : #accessing }
BlConcreteVisuals >> geometry [
	^ geometry ifNil: [ self defaultGeometry ]
]

{ #category : #accessing }
BlConcreteVisuals >> geometry: aBlElementGeometry [
	"Change the geometry and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	geometry := aBlElementGeometry
]

{ #category : #accessing }
BlConcreteVisuals >> mouseCursor [
	^ mouseCursor ifNil: [ self defaultMouseCursor ]
]

{ #category : #accessing }
BlConcreteVisuals >> mouseCursor: aBlCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	mouseCursor := aBlCursor
]

{ #category : #accessing }
BlConcreteVisuals >> opacity [
	^ opacity ifNil: [ self defaultOpacity ]
]

{ #category : #accessing }
BlConcreteVisuals >> opacity: aNumber [
	"Change the opacity and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	opacity := aNumber
]

{ #category : #accessing }
BlConcreteVisuals >> outskirts [
	^ outskirts ifNil: [ self defaultOutskirts ]
]

{ #category : #accessing }
BlConcreteVisuals >> outskirts: aBlOutskirts [
	"Change the outskirts and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	outskirts := aBlOutskirts
]

{ #category : #accessing }
BlConcreteVisuals >> visibility [
	^ visibility ifNil: [ self defaultVisibility ]
]

{ #category : #accessing }
BlConcreteVisuals >> visibility: aBlVisibility [
	"Change the visibility and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	visibility := aBlVisibility
]
