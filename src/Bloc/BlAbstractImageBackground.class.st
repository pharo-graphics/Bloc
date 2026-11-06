"
I am the abstract class of the backgrounds that draw a bitmap.

### Responsibility
- Gather what my subclasses share: they draw their bitmap at its own size, from the top-left corner of the element,
  neither scaled nor repeated, and clipped by the geometry of the element.
- Tell whether there is nothing to draw (`isTransparent`): when my opacity is 0 or my bitmap has no pixels (`width` or `height` is 0).

### Collaborators
- My subclasses:
  - `BlImageBackground` draws a `Form`.
  - `BlFormSetBackground` draws a `FormSet` (the same image at several resolutions).
- `BlBackground class >> #image:` and `BlBackground class >> #formSet:` create my subclasses,
  as do `Form >> #asBlBackground` and `FormSet >> #asBlBackground`.

### Public API
I am abstract: use my subclasses.
```
BlBackground image: aForm.
BlBackground formSet: aFormSet.
anElement background: aForm.
anElement background: aFormSet.
```
See `BlImageBackground class >> #exampleImage` and `BlFormSetBackground class >> #exampleFormSet`.

### Implementation Points
- My subclasses implement `width` and `height` (the size of the bitmap in logical pixels), `aeApplyTo:`, `=` and `hash`.
- `isTransparent` does not check whether all the pixels are transparent:
  there is no fast way to do that without reading every pixel.
- `matchExtent:` does nothing: the bitmap is not adapted to the extent of the element.
"
Class {
	#name : #BlAbstractImageBackground,
	#superclass : #BlBackground,
	#category : #'Bloc-Basic-Background'
}

{ #category : #'private - demo' }
BlAbstractImageBackground class >> demoFormAtScale: aScale [
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

{ #category : #testing }
BlAbstractImageBackground class >> isAbstract [

	^ self = BlAbstractImageBackground
]

{ #category : #accessing }
BlAbstractImageBackground >> height [

	self subclassResponsibility
]

{ #category : #testing }
BlAbstractImageBackground >> isTransparent [
	"Unfortunately there is no fast way to detect if a Form is completely transparent,
	the only check we can afford to do is to see whether the extent of the form is positive"

	^ (self opacity closeTo: 0.0) or: [ self width = 0 or: [ self height = 0 ] ]
]

{ #category : #geometry }
BlAbstractImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]

{ #category : #accessing }
BlAbstractImageBackground >> width [

	self subclassResponsibility
]
