"
I am the abstract class of the objects that hold the visual properties of a `BlElement`:
its background, border, geometry, outskirts, effect, opacity, visibility, clipping of children,
compositing mode and elevation. I also hold a few properties that are not strictly visual:
focusability, the focused state and the mouse cursor.

### Responsibility

- Define the API shared by my subclasses: one getter and one setter per property (`opacity`, `opacity:`, ...).
- Hold the default value of each property in shared variables (`DefaultOpacity`, `DefaultBackground`, ...),
  initialized by `BlElementVisuals class >> #initialize`, and answer them through `default…` methods.

### Collaborators

- `BlElement` stores me in its `visuals` instance variable and delegates its visual property accessors to me.
- `BlDefaultVisuals`: the shared instance used by every element that has not changed any property.
- `BlCustomVisuals`: the per-element instance that stores the changed properties.

### Public API

The setters follow an unusual contract: **a setter answers the visuals to use from now on**, which may be
another object than the receiver. Callers must always store the result:

```
BlElement >> opacity: aNumber
	...
	visuals := visuals opacity: aNewOpacity.
	self invalidate
```

You normally do not use me directly: send the corresponding messages to the element
(`anElement opacity: 0.5`, `anElement background: Color red`).
Run `BlCustomVisuals class >> #scriptElementVisuals`.

### Implementation Points

This design saves memory: most elements never change their visual properties, so they all share one
`BlDefaultVisuals` instance instead of each holding a full object. Only elements that change a property
pay for a `BlCustomVisuals`.

The defaults are shared variables read at access time. Changing one (e.g. by re-running
`BlElementVisuals class >> #initialize`) affects every element that has not set that property.
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
