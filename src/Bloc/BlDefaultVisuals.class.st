"
I am the visuals shared by all the elements that have not changed any visual property.
`BlElement >> #initialize` sets `visuals` to `BlDefaultVisuals uniqueInstance`.

### Responsibility

- Answer the default value of every property (my getters answer `self default…`).
- Never change: since I am shared, my setters do not modify me. Each one answers a new `BlCustomVisuals`
  holding the new value, which the element then stores in place of me.

```
BlDefaultVisuals >> opacity: aNumber
	""Return a <BlElementVisuals>""
	
	^ BlCustomVisuals new opacity: aNumber
```

### Collaborators

- `BlCustomVisuals`, which I create on the first change.
- `BlElement`, which must store the result of my setters (see `BlElementVisuals`).

### Public API

- `BlDefaultVisuals uniqueInstance`: the shared instance.
- `BlDefaultVisuals cleanUp`: forget it; the next `uniqueInstance` creates a new one.

### Implementation Points

An alternative would be one class with an instance variable pointing to a shared default object.
But then the shared object would have to be copied before each change. With two classes,
the switch from shared to private happens once, on the first change, through polymorphism.
"
Class {
	#name : #BlDefaultVisuals,
	#superclass : #BlElementVisuals,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlDefaultVisuals class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlDefaultVisuals class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlDefaultVisuals >> background [
	^ self defaultBackground
]

{ #category : #accessing }
BlDefaultVisuals >> background: aBlBackground [
	"Change the background and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new background: aBlBackground
]

{ #category : #accessing }
BlDefaultVisuals >> border [
	^ self defaultBorder
]

{ #category : #accessing }
BlDefaultVisuals >> border: aBlBorder [
	"Change the border and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new border: aBlBorder
]

{ #category : #accessing }
BlDefaultVisuals >> clipChildren [
	^ self defaultClipChildren
]

{ #category : #accessing }
BlDefaultVisuals >> clipChildren: aBoolean [
	"Change if children should be clipped and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new clipChildren: aBoolean
]

{ #category : #accessing }
BlDefaultVisuals >> compositingMode [
	^ self defaultCompositingMode
]

{ #category : #accessing }
BlDefaultVisuals >> compositingMode: aBlCompositingMode [
	"Change the compositing mode and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new compositingMode: aBlCompositingMode
]

{ #category : #accessing }
BlDefaultVisuals >> effect [
	^ self defaultEffect
]

{ #category : #accessing }
BlDefaultVisuals >> effect: aBlElementEffect [
	"Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new effect: aBlElementEffect
]

{ #category : #accessing }
BlDefaultVisuals >> elevation [
	^ self defaultElevation
]

{ #category : #accessing }
BlDefaultVisuals >> elevation: aBlElevation [
	"Change the elevation and return new visuals to be used instead of the previous one (not necessarily a new instance)"

	^ BlCustomVisuals new
		  elevation: aBlElevation;
		  yourself
]

{ #category : #accessing }
BlDefaultVisuals >> focusability [
	^ self defaultFocusability
]

{ #category : #accessing }
BlDefaultVisuals >> focusability: aBlFocusability [
	"Change the focusability and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new focusability: aBlFocusability
]

{ #category : #accessing }
BlDefaultVisuals >> focused: aBoolean [
	"Change focused state and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new focused: aBoolean
]

{ #category : #accessing }
BlDefaultVisuals >> geometry [
	^ self defaultGeometry
]

{ #category : #accessing }
BlDefaultVisuals >> geometry: aBlElementGeometry [
	"Change the geometry and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new geometry: aBlElementGeometry
]

{ #category : #testing }
BlDefaultVisuals >> isFocused [

	^ self defaultFocused
]

{ #category : #accessing }
BlDefaultVisuals >> mouseCursor [
	^ self defaultMouseCursor
]

{ #category : #accessing }
BlDefaultVisuals >> mouseCursor: aCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new mouseCursor: aCursor
]

{ #category : #accessing }
BlDefaultVisuals >> opacity [
	^ self defaultOpacity
]

{ #category : #accessing }
BlDefaultVisuals >> opacity: aNumber [
	"Change the opacity and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new opacity: aNumber
]

{ #category : #accessing }
BlDefaultVisuals >> outskirts [
	^ self defaultOutskirts
]

{ #category : #accessing }
BlDefaultVisuals >> outskirts: aBlOutskirts [
	"Change the outskirts and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new outskirts: aBlOutskirts
]

{ #category : #accessing }
BlDefaultVisuals >> visibility [
	^ self defaultVisibility
]

{ #category : #accessing }
BlDefaultVisuals >> visibility: aBlVisibility [
	"Change the visibility and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new visibility: aBlVisibility
]
