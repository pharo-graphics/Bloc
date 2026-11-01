"
I hold the visual properties of one element that has changed at least one of them.
I am created by a `BlDefaultVisuals` setter the first time a property of the element changes,
and I then replace the shared default visuals in that element.

### Responsibility

- Store the properties that were set. My setters modify me (and answer me), so after the first change
  the element keeps the same instance.
- Answer the default value for any property that was not set: each instance variable is nil until set,
  and my getters fall back to `self default…` (e.g. `^ opacity ifNil: [ self defaultOpacity ]`).

### Collaborators

- `BlDefaultVisuals`, which creates me.
- `BlElement`, which stores me and must still store the result of my setters,
  to respect the `BlElementVisuals` contract.

### Public API

The same as `BlElementVisuals`. Run `BlCustomVisuals class >> #scriptElementVisuals` to see how an element
switches from the shared default visuals to its own; `#exampleTranslucentRounded` answers such visuals.

### Internal Representation and Key Implementation Points

**Instance Variables**
- background, border, geometry, outskirts, effect, opacity, visibility, clipChildren,
  compositingMode, elevation, focusability, focused, mouseCursor: the value set for each property,
  or nil when it was not set (the default is then used).

Setting a property back to its default value does not turn the element back to the shared
`BlDefaultVisuals`: the element keeps its `BlCustomVisuals`.
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
	#category : #'Bloc-Basic'
}

{ #category : #'private - demo' }
BlCustomVisuals class >> demoCellFor: anElement [
	"Answer a cell showing anElement in a gray frame, above the name of its visuals class.
	The visuals are read with #instVarNamed: only to display them: client code never accesses them."

	| frame label |
	frame := BlElement new
		         extent: 80 @ 80;
		         border: (BlBorder paint: Color gray width: 1);
		         yourself.
	frame addChild: anElement.
	label := BlTextElement new text: (anElement instVarNamed: #visuals) class name asRopedText.
	^ BlElement new
		  layout: (BlLinearLayout vertical interspace: 10);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: {
				  frame.
				  label };
		  yourself
]

{ #category : #examples }
BlCustomVisuals class >> exampleTranslucentRounded [
	"Answer the visuals of an element after it changed three properties.
	The first setter, sent to the shared default visuals, answers a new instance of me.
	Users don't build visuals themselves: see #scriptElementVisuals for how an element gets them."

	<sampleInstance>
	^ (BlDefaultVisuals uniqueInstance opacity: 0.5)
		  background: (BlBackground paint: Color blue);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
		  yourself
]

{ #category : #script }
BlCustomVisuals class >> scriptElementVisuals [
	"Show how an element gets its visuals. You never create or change visuals yourself:
	you send the visual messages (opacity:, background:, geometry:, ...) to the element,
	which stores the visuals they answer.
	Left, an untouched element shares the default visuals.
	Right, an element that received the properties of #exampleTranslucentRounded
	through the element API now has its own custom visuals."

	<script>
	| example untouched configured container |
	example := self exampleTranslucentRounded.
	untouched := BlElement new extent: 80 @ 80.
	configured := BlElement new extent: 80 @ 80.
	configured
		opacity: example opacity;
		background: example background;
		geometry: example geometry.
	container := BlElement new
		             layout: (BlLinearLayout horizontal interspace: 40);
		             padding: (BlInsets all: 40);
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             yourself.
	{
		untouched.
		configured } do: [ :each | container addChild: (self demoCellFor: each) ].
	container openInSpace
]

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

{ #category : #testing }
BlCustomVisuals >> isFocused [

	^ focused ifNil: [ self defaultFocused ]
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
