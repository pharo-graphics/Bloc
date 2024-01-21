"
I'm the counterpart of the `BlDefaultVisuals`. I'm usually stored in place of `BlDefaultVisuals` singleton to accumulate modifications of the default. I accumulate modifications because contrary to `BlDefaultVisuals` my setters modify myself.

To use me correctly my users should always store the result of the setters sent to a visuals as shown in the example below.

```
BlElement >> effect: anEffect
	""Change my effect to a given one requesting draw area invalidations.
	anEffect must not be nil""

	visuals := visuals effect: anEffect.
	self invalidate
```
"
Class {
	#name : #BlCustomVisuals,
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
	#category : 'Bloc-Basic'
}

{ #category : #accessing }
BlCustomVisuals >> background [
	^ background ifNil: [ self defaultBackground ]
]

{ #category : #accessing }
BlCustomVisuals >> background: aBlBackground [
	"Change the background and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	background := aBlBackground
]

{ #category : #accessing }
BlCustomVisuals >> border [
	^ border ifNil: [ self defaultBorder ]
]

{ #category : #accessing }
BlCustomVisuals >> border: aBlBorder [
	"Change the border and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	border := aBlBorder
]

{ #category : #accessing }
BlCustomVisuals >> clipChildren [
	^ clipChildren ifNil: [ self defaultClipChildren ]
]

{ #category : #accessing }
BlCustomVisuals >> clipChildren: aBoolean [
	"Change if children should be clipped and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	clipChildren := aBoolean
]

{ #category : #accessing }
BlCustomVisuals >> compositingMode [
	^ compositingMode ifNil: [ self defaultCompositingMode ]
]

{ #category : #accessing }
BlCustomVisuals >> compositingMode: aBlCompositingMode [
	"Change the compositing mode and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	compositingMode := aBlCompositingMode
]

{ #category : #accessing }
BlCustomVisuals >> effect [
	^ effect ifNil: [ self defaultEffect ]
]

{ #category : #accessing }
BlCustomVisuals >> effect: aBlElementEffect [
	"Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)."
	<return: #BlElementVisuals>

	effect := aBlElementEffect
]

{ #category : #accessing }
BlCustomVisuals >> elevation [
	^ elevation ifNil: [ self defaultElevation ]
]

{ #category : #accessing }
BlCustomVisuals >> elevation: aBlElevation [
	"Change the elevation and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	elevation := aBlElevation
]

{ #category : #accessing }
BlCustomVisuals >> focusability [
	^ focusability ifNil: [ self defaultFocusability ]
]

{ #category : #accessing }
BlCustomVisuals >> focusability: aBlFocusability [
	"Change the focusability and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	focusability := aBlFocusability
]

{ #category : #accessing }
BlCustomVisuals >> focused [
	^ focused ifNil: [ self defaultFocused ]
]

{ #category : #accessing }
BlCustomVisuals >> focused: aBoolean [
	"Change focused state and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	focused := aBoolean
]

{ #category : #accessing }
BlCustomVisuals >> geometry [
	^ geometry ifNil: [ self defaultGeometry ]
]

{ #category : #accessing }
BlCustomVisuals >> geometry: aBlElementGeometry [
	"Change the geometry and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	geometry := aBlElementGeometry
]

{ #category : #accessing }
BlCustomVisuals >> mouseCursor [
	^ mouseCursor ifNil: [ self defaultMouseCursor ]
]

{ #category : #accessing }
BlCustomVisuals >> mouseCursor: aCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	mouseCursor := aCursor
]

{ #category : #accessing }
BlCustomVisuals >> opacity [
	^ opacity ifNil: [ self defaultOpacity ]
]

{ #category : #accessing }
BlCustomVisuals >> opacity: aNumber [
	"Change the opacity and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	opacity := aNumber
]

{ #category : #accessing }
BlCustomVisuals >> outskirts [
	^ outskirts ifNil: [ self defaultOutskirts ]
]

{ #category : #accessing }
BlCustomVisuals >> outskirts: aBlOutskirts [
	"Change the outskirts and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	outskirts := aBlOutskirts
]

{ #category : #accessing }
BlCustomVisuals >> visibility [
	^ visibility ifNil: [ self defaultVisibility ]
]

{ #category : #accessing }
BlCustomVisuals >> visibility: aBlVisibility [
	"Change the visibility and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	visibility := aBlVisibility
]
