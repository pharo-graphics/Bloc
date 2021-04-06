"
I'm a singleton that holds many default values to be shared between multiples elements. 
In addition, I'm kind of read only because when my setters are executed, they do not modify myself but 
create and return a new instance of `BlCustomVisuals`.

Check for example:

```
BlDefaultVisuals >> effect: aBlElementEffect
		""Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)""
		<return: #BlElementVisuals>

		^ BlCustomVisuals new effect: aBlElementEffect
```

The KEY point is that in BlElement the RESULT of the setter (badly name message in fact) must be stored.

```
BlElement >> effect: anEffect
		""Change my effect to a given one requesting draw area invalidations.
		anEffect must not be nil""

		visuals := visuals effect: anEffect.
		self invalidate
```

My counterpart, `BlCustomVisuals` is offering the same API but its setter are normal setters that modify the instance. 


```
BlCustomVisuals >> effect: aBlElementEffect
		""Change the effect and return new visuals to be used instead of the previous one (not necessarily a new instance)""
		<return: #BlElementVisuals>

		effect := aBlElementEffect
```

### Discussion 
The result could have been achieved by having an instance variable and a classVariable with the instance variable pointing to the classVariable by default. But this implementation would have forced to copy the customized version after each setter. 





	
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
	<return: #BlElementVisuals>

	^ BlCustomVisuals new elevation: aBlElevation
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
BlDefaultVisuals >> focused [
	^ self defaultFocused
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

{ #category : #accessing }
BlDefaultVisuals >> mouseCursor [
	^ self defaultMouseCursor
]

{ #category : #accessing }
BlDefaultVisuals >> mouseCursor: aBlCursor [
	"Change the mouse cursor and return new visuals to be used instead of the previous one (not necessarily a new instance)"
	<return: #BlElementVisuals>

	^ BlCustomVisuals new mouseCursor: aBlCursor
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
