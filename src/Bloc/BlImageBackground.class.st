"
I am a background that draws a bitmap, given as a `Form`.

### Responsibility

- Draw my form at its own size, from the top-left corner of the element: it is neither scaled nor repeated.
  When the element is larger than the form, the rest of the element is not covered.
  The form is clipped by the geometry of the element.
- Apply my opacity to the whole form.

### Collaborators

- `Form`: `aForm asBlBackground` answers me, so `anElement background: aForm` creates me.
- `BlAbstractImageBackground`, my superclass, shared with `BlFormSetBackground`,
  which draws a `FormSet` (the same image at several resolutions).

### Public API

```
BlImageBackground image: aForm.
(BlImageBackground image: aForm) opacity: 0.5.
anElement background: aForm.
```

See `BlImageBackground class >> #exampleImage`, and run `BlImageBackground class >> #scriptImagePlacement`.

### Implementation Points

- I am transparent only when my opacity is 0 or my form is empty, never because all its pixels are transparent:
  there is no fast way to check that without reading every pixel.
- `matchExtent:` does nothing: the form is not adapted to the extent of the element.
- Like all backgrounds, I am immutable: `image:` can be sent only once.
- Two image backgrounds are equal when they have the same opacity and equal forms.

**Instance Variables**
- image: the `Form` I draw.
"
Class {
	#name : #BlImageBackground,
	#superclass : #BlAbstractImageBackground,
	#instVars : [
		'image'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #examples }
BlImageBackground class >> exampleImage [
	"Answer an image background showing the Pharo logo on a light blue rectangle of 100 x 50 pixels."

	<sampleInstance>
	^ self image: (self demoFormAtScale: 1)
]

{ #category : #'instance creation' }
BlImageBackground class >> image: aForm [

	^ self new
		image: aForm;
		yourself
]

{ #category : #script }
BlImageBackground class >> scriptImagePlacement [
	"Show how an image background is drawn: at its own size from the top-left corner (left),
	clipped by the geometry of the element (middle), and with an opacity (right)."

	<script>
	| image |
	image := self exampleImage image.
	self demoOpen: {
			(self
				 demoCellFor: (BlElement new
						  extent: 130 @ 70;
						  background: (self image: image);
						  yourself)
				 caption: 'own size, top-left').
			(self
				 demoCellFor: (BlElement new
						  extent: 70 @ 70;
						  geometry: BlCircleGeometry new;
						  background: (self image: image);
						  yourself)
				 caption: 'clipped by geometry').
			(self
				 demoCellFor: (BlElement new
						  extent: 130 @ 70;
						  background: ((self image: image) opacity: 0.4);
						  yourself)
				 caption: 'opacity: 0.4') }
]

{ #category : #comparing }
BlImageBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject image = self image
]

{ #category : #comparing }
BlImageBackground >> hash [

	^ super hash bitXor: self image hash
]

{ #category : #accessing }
BlImageBackground >> height [

	^ image height
]

{ #category : #accessing }
BlImageBackground >> image [
	"Return the form that represents the visual of the background."

	^ image
]

{ #category : #accessing }
BlImageBackground >> image: aForm [

	image isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	image := aForm
]

{ #category : #accessing }
BlImageBackground >> width [

	^ image width
]
