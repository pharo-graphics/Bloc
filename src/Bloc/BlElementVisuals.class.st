"
# Element's visual properties

"
Class {
	#name : #BlElementVisuals,
	#superclass : #Object,
	#classVars : [
		'DefaultBackground',
		'DefaultBorder',
		'DefaultClipChildren',
		'DefaultCompositingMode',
		'DefaultEffect',
		'DefaultElevation',
		'DefaultFocusability',
		'DefaultFocused',
		'DefaultGeometry',
		'DefaultMouseCursor',
		'DefaultOpacity',
		'DefaultOutskirts',
		'DefaultVisibility'
	],
	#category : #'Bloc-Basic'
}

{ #category : #initialization }
BlElementVisuals class >> defaultBackground [
	^ DefaultBackground
]

{ #category : #initialization }
BlElementVisuals class >> defaultBorder [
	^ DefaultBorder
]

{ #category : #initialization }
BlElementVisuals class >> defaultGeometry [
	^ DefaultGeometry
]

{ #category : #'class initialization' }
BlElementVisuals class >> initialize [
	DefaultBackground := BlBackground transparent.
	DefaultGeometry := BlRectangleGeometry new.
	DefaultBorder := BlBorder empty.
	DefaultEffect := BlNullEffect new.
	DefaultOpacity := 1.0.
	DefaultVisibility := BlVisibility visible.
	DefaultOutskirts := BlOutskirts inside.
	DefaultClipChildren := true.
	DefaultCompositingMode := BlCompositingWithoutLayerMode uniqueInstance.
	DefaultFocusability := BlFocusability before.
	DefaultElevation := BlRelativeElevation zero.
	DefaultFocused := false.
	DefaultMouseCursor := nil
]

{ #category : #accessing }
BlElementVisuals >> background [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> background: aBlBackground [
	"Change the background and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> border [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> border: aBlBorder [
	"Change the border and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> clipChildren [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> clipChildren: aBoolean [
	"Change if children should be clipped and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> compositingMode [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> compositingMode: aBlCompositingMode [
	"Change the compositing mode and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlElementVisuals >> defaultBackground [
	^ DefaultBackground
]

{ #category : #initialization }
BlElementVisuals >> defaultBorder [
	^ DefaultBorder
]

{ #category : #initialization }
BlElementVisuals >> defaultClipChildren [
	^ DefaultClipChildren
]

{ #category : #initialization }
BlElementVisuals >> defaultCompositingMode [
	^ DefaultCompositingMode
]

{ #category : #initialization }
BlElementVisuals >> defaultEffect [
	^ DefaultEffect
]

{ #category : #initialization }
BlElementVisuals >> defaultElevation [
	^ DefaultElevation
]

{ #category : #initialization }
BlElementVisuals >> defaultFocusability [
	^ DefaultFocusability
]

{ #category : #initialization }
BlElementVisuals >> defaultFocused [
	^ DefaultFocused
]

{ #category : #initialization }
BlElementVisuals >> defaultGeometry [
	^ DefaultGeometry
]

{ #category : #initialization }
BlElementVisuals >> defaultMouseCursor [
	^ DefaultMouseCursor
]

{ #category : #initialization }
BlElementVisuals >> defaultOpacity [
	^ DefaultOpacity
]

{ #category : #initialization }
BlElementVisuals >> defaultOutskirts [
	^ DefaultOutskirts
]

{ #category : #initialization }
BlElementVisuals >> defaultVisibility [
	^ DefaultVisibility
]

{ #category : #accessing }
BlElementVisuals >> effect [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> effect: aBlElementEffect [
	"Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> elevation [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> elevation: aBlElevation [
	"Change the elevation and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> focusability [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> focusability: aBlFocusability [
	"Change the focusability and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> focused: aBoolean [
	"Change focused state and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> geometry [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> geometry: aBlElementGeometry [
	"Change the geometry and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #testing }
BlElementVisuals >> isFocused [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> mouseCursor [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> mouseCursor: aCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> opacity [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> opacity: aNumber [
	"Change the opacity and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> outskirts [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> outskirts: aBlOutskirts [
	"Change the outskirts and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> visibility [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementVisuals >> visibility: aBlVisibility [
	"Change the visibility and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ self subclassResponsibility
]
