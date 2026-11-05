"
I am a background that draws a bitmap given as a `FormSet`: the same image at several resolutions,
for example one form for a normal display and one with twice as many pixels for a display with a scale of 2.

### Responsibility
- Draw the form of my form set that matches the scale of the display: the Alexandrie canvas asks the
  form set for `asFormAtScale:` with its device scale rounded, so the image stays sharp on a high resolution display.
- Draw it at the logical size of the form set (its `extent`), from the top-left corner of the element:
  it is neither scaled to the element nor repeated. When the element is larger, the rest of the element is not covered.
  The image is clipped by the geometry of the element.
- Apply my opacity to the whole image.

### Collaborators
- `FormSet`: `aFormSet asBlBackground` answers me, so `anElement background: aFormSet` creates me.
- `BlAbstractImageBackground`, my superclass, shared with `BlImageBackground`, which draws a single `Form`.
- `AeCanvas >> #setBackgroundWithFormSet:alpha:` draws me; it caches the converted surface per form set.

### Public API
```
BlFormSetBackground formSet: aFormSet.
BlBackground formSet: aFormSet.
(BlFormSetBackground formSet: aFormSet) opacity: 0.5.
anElement background: aFormSet.
```
See `BlFormSetBackground class >> #exampleFormSet`, and run `BlFormSetBackground class >> #scriptFormSetPlacement`.

### Implementation Points
- I am transparent only when my opacity is 0 or my form set has an empty extent, never because all its pixels are transparent.
- `matchExtent:` does nothing: the form set is not adapted to the extent of the element.
- Like all backgrounds, I am immutable: `formSet:` can be sent only once.
- Two form set backgrounds are equal when they have the same opacity and equal form sets. `FormSet` does not redefine `=`,
  so in practice they must share the same form set instance. `hash` combines the opacity and the form set, consistently with `=`.
- The canvas caches the drawn surface per form set: after changing the pixels of a form of the set, send `resetFormCaches` to the canvas.

**Instance Variables**
- formSet: the `FormSet` I draw.
"
Class {
	#name : #BlFormSetBackground,
	#superclass : #BlAbstractImageBackground,
	#instVars : [
		'formSet'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'private - demo' }
BlFormSetBackground class >> demoFormAtScale: aScale [
	"Answer the Pharo logo on an opaque light blue rectangle of (100 x 50) * aScale pixels."

	| form |
	form := (Form extent: 100 @ 50 * aScale depth: 32)
		        fillColor: (Color r: 0.85 g: 0.92 b: 1.0);
		        yourself.
	form getCanvas
		translucentImage: (PolymorphSystemSettings pharoLogoForm scaledToSize: 100 @ 34 * aScale)
		at: 0 @ 8 * aScale.
	^ form
]

{ #category : #'private - demo' }
BlFormSetBackground class >> demoFormSet [
	"Answer a 100 x 50 form set: the Pharo logo on an opaque light blue rectangle,
	with a form for scale 1 (100 x 50 pixels) and one for scale 2 (200 x 100 pixels).
	The canvas draws the form that matches the scale of the display."

	^ FormSet
		  extent: 100 @ 50
		  depth: 32
		  forms: { 
				  (self demoFormAtScale: 1).
				  (self demoFormAtScale: 2) }
]

{ #category : #examples }
BlFormSetBackground class >> exampleFormSet [
	"Answer a form set background showing the Pharo logo on a light blue rectangle of 100 x 50 pixels,
	at scale 1 and at scale 2."

	<sampleInstance>
	^ self formSet: self demoFormSet
]

{ #category : #'instance creation' }
BlFormSetBackground class >> formSet: aFormSet [

	^ self new
		formSet: aFormSet;
		yourself
]

{ #category : #script }
BlFormSetBackground class >> scriptFormSetPlacement [
	"Show how a form set background is drawn: like an image background, at its own size from the top-left corner (left),
	clipped by the geometry of the element (middle), and with an opacity (right).
	On a display with a scale of 2, the 200 x 100 form of the set is used, so the logo stays sharp."

	<script>
	| formSet |
	formSet := self exampleFormSet formSet.
	self demoOpen: { 
			(self
				 demoCellFor: (BlElement new
						  extent: 130 @ 70;
						  background: (self formSet: formSet);
						  yourself)
				 caption: 'own size, top-left').
			(self
				 demoCellFor: (BlElement new
						  extent: 70 @ 70;
						  geometry: BlCircleGeometry new;
						  background: (self formSet: formSet);
						  yourself)
				 caption: 'clipped by geometry').
			(self
				 demoCellFor: (BlElement new
						  extent: 130 @ 70;
						  background: ((self formSet: formSet) opacity: 0.4);
						  yourself)
				 caption: 'opacity: 0.4') }
]

{ #category : #comparing }
BlFormSetBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject formSet = self formSet
]

{ #category : #accessing }
BlFormSetBackground >> formSet [

	^ formSet
]

{ #category : #accessing }
BlFormSetBackground >> formSet: aFormSet [

	formSet isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	formSet := aFormSet
]

{ #category : #comparing }
BlFormSetBackground >> hash [

	^ super hash bitXor: self formSet hash
]

{ #category : #accessing }
BlFormSetBackground >> height [

	^ formSet height
]

{ #category : #accessing }
BlFormSetBackground >> width [

	^ formSet width
]
