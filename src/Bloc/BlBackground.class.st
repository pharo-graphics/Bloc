"
I am the abstract class of the backgrounds of a `BlElement`: what is painted inside the element's geometry,
under its border and its children.

### Responsibility

- Describe how to fill the element's geometry: with a paint (a color or a gradient), a bitmap,
  a composition of backgrounds, or nothing.
- Carry an opacity, from 0 (invisible) to 1 (opaque, the default).
- Draw myself on an Alexandrie canvas (`aeApplyTo:`); the drawing is clipped by the element's geometry.
- Tell whether there is nothing to draw (`isTransparent`) or whether I cover everything (`isOpaque`).

### Collaborators

- `BlElement >> #background:` accepts me, or any object that understands `asBlBackground`:
  `Color`, `BlPaint`, `Form` and `FormSet`.
- My subclasses: `BlPaintBackground`, `BlImageBackground` and `BlFormSetBackground`
  (both under `BlAbstractImageBackground`), `BlCompositeBackground`, `BlTransparentBackground`.
- `BlCompositeBackgroundBuilder`, answered by `BlBackground builder`.

### Public API

The simplest way is to give a color or a form to the element:

```
anElement background: Color blue.
anElement background: aForm.
```

The instance creation messages on my class side answer the right subclass:

```
BlBackground paint: Color blue.
BlBackground paint: aGradientPaint.
BlBackground image: aForm.
BlBackground formSet: aFormSet.
BlBackground transparent.
BlBackground builder paint: Color yellow; image: aForm; build.
```

**I am immutable.** Once my opacity or my content (paint, image, ...) is set, setting it again raises
`BlImmutableObjectChangeError`. Set the opacity right after creation, e.g. `(BlBackground paint: Color blue) opacity: 0.5`.
To change the background of an element, create a new background and send `background:` again.

Run `BlBackground class >> #scriptBackgroundKinds`.

### Implementation Points

- My subclasses implement `aeApplyTo:`, `isTransparent` and `matchExtent:` (used to adapt e.g. a gradient
  to the extent of the element), and compare by value (`=` and `hash`):
  `BlElement >> #background:` does nothing when the new background equals the current one.
- My opacity is nil until set, and `opacity` then answers `defaultOpacity` (1.0).

**Instance Variables**
- opacity: a number between 0 and 1, or nil for the default (opaque).
"
Class {
	#name : #BlBackground,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'opacity'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #builder }
BlBackground class >> builder [

	^ BlCompositeBackgroundBuilder new
]

{ #category : #'private - demo' }
BlBackground class >> demoCellFor: anElement caption: aString [
	"Answer anElement in a gray frame, above aString and the class of its background."

	| frame |
	frame := BlElement new
		         layout: BlFrameLayout new;
		         border: (BlBorder paint: Color gray width: 1);
		         constraintsDo: [ :c |
				         c horizontal fitContent.
				         c vertical fitContent ];
		         yourself.
	frame addChild: anElement.
	^ BlElement new
		  layout: (BlLinearLayout vertical interspace: 6);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: {
				  frame.
				  (BlTextElement new text: aString asRopedText).
				  (BlTextElement new text: anElement background class name asRopedText) };
		  yourself
]

{ #category : #'private - demo' }
BlBackground class >> demoOpen: aCollectionOfCells [
	"Open a space showing the cells side by side."

	(BlElement new
		 layout: (BlLinearLayout horizontal interspace: 30);
		 padding: (BlInsets all: 30);
		 background: Color white;
		 constraintsDo: [ :c |
				 c horizontal fitContent.
				 c vertical fitContent ];
		 addChildren: aCollectionOfCells;
		 yourself) openInSpace
]

{ #category : #'instance creation' }
BlBackground class >> formSet: aFormSet [
	
	^ BlFormSetBackground formSet: aFormSet
]

{ #category : #'instance creation' }
BlBackground class >> image: aForm [
	
	^ BlImageBackground image: aForm
]

{ #category : #'instance creation' }
BlBackground class >> paint: aColorOrBlPaint [

	^ BlPaintBackground paint: aColorOrBlPaint
]

{ #category : #script }
BlBackground class >> scriptBackgroundKinds [
	"Show the main kinds of backgrounds, each created the simplest way and given to an element.
	The caption says what was given to #background:; below it is the class of the resulting background.
	Composite backgrounds are not shown: they currently draw only their last background (see BACKLOG.md)."

	<script>
	self demoOpen: {
			(self
				 demoCellFor: (BlElement new
						  extent: 120 @ 60;
						  background: Color blue;
						  yourself)
				 caption: 'Color blue').
			(self
				 demoCellFor: (BlElement new
						  extent: 120 @ 60;
						  background: (BlBackground paint: (BlLinearGradientPaint horizontal
										    stops: {
												    (0 -> Color blue).
												    (1 -> Color red) };
										    yourself));
						  yourself)
				 caption: 'a gradient paint').
			(self
				 demoCellFor: (BlElement new
						  extent: 120 @ 60;
						  background: BlImageBackground exampleImage image;
						  yourself)
				 caption: 'a Form').
			(self
				 demoCellFor: (BlElement new
						  extent: 120 @ 60;
						  background: BlBackground transparent;
						  yourself)
				 caption: 'BlBackground transparent') }
]

{ #category : #'instance creation' }
BlBackground class >> transparent [
	"Return a completely transparent background"
	
	^ BlTransparentBackground uniqueInstance
]

{ #category : #converting }
BlBackground >> asBlBackground [

	^ self
]

{ #category : #initialization }
BlBackground >> defaultOpacity [
	"By default background is completely opaque so it returns a float indicating it: 1.0"

	^ 1.0
]

{ #category : #comparing }
BlBackground >> hash [

	^ self class hash bitXor: self opacity hash
]

{ #category : #testing }
BlBackground >> isColorBackground [

	^ self isPaintBackground and: [ self paint isColorPaint ]
]

{ #category : #testing }
BlBackground >> isOpaque [
	"Return true if the whole background is opaque"
	
	^ false
]

{ #category : #testing }
BlBackground >> isPaintBackground [

	^ false
]

{ #category : #testing }
BlBackground >> isTransparent [
	"Return true if background is transparent and should not be rendered, false otherwise"

	^ self subclassResponsibility
]

{ #category : #geometry }
BlBackground >> matchExtent: anExtent [
	"Resize background to match given extent.
	Used to adapt image or gradient backgrounds to the element's extent"

	self subclassResponsibility
]

{ #category : #accessing }
BlBackground >> opacity [
	"Return a float representing the opacity of the receiver. 1.0 meaning that it is opaque and 0 that it is fully transparent."

	^ opacity ifNil: [ self defaultOpacity ]
]

{ #category : #accessing }
BlBackground >> opacity: aNumber [
	"Opacity value must be within interval [0..1]. 1.0 meaning that the receiver is opaque."

	opacity isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
	self opacity = aNumber
		ifTrue: [ ^ self ].
	opacity := aNumber
]

{ #category : #accessing }
BlBackground >> paint [

	^ nil
]
