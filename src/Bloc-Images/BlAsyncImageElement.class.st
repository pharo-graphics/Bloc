"
BlAsyncImageElement is an abstract class that provides a framework for Bloc elements that display an image that should be loaded in a background processes (to leave the UI responsive).

Each subclass BlAsyncImageElement requires a matching ${class:name=BlAsyncElementValuable}$ that is responsible for doing the work of retrieving the ${class:name=Form}$ and updating the receiver.

BlAsyncImageElement minimises memory and CPU usage by ensuring that the ${class:name=Form}$ held in memory is approximately the same size as the on-screen display size.  This ensures that memory is not wasted in the case where the form is much larger than the on-screen area, and that image quality is not compromised in the case where the form is much smaller than the on-screen display size.  See ${method:name=BlAsyncImageElement>>#needsUpdate}$.

Subclasses of BlAsyncImageElement are responsible for holding the details of how to retrieve the image and answering their valuable, see ${method:name=BlAsyncImageElement>>#queueEntry}$ and  ${method:name=BlAsyncElementValuable>>#updateElement}$.

!!Public API and Key Messages

BlAsyncImageElement has the same public API as BlElement.  As an abstract class, it shouldn't be instantiated.

 
!!Internal Representation and Key Implementation Points

!!!Instance Variables
	bitmap:		<MozSurface>  Moz2D representation of the form.
	form:			<Form>  The image being displayed.


!!Implementation Points
"
Class {
	#name : #BlAsyncImageElement,
	#superclass : #BlAsyncElement,
	#instVars : [
		'entry',
		'bitmap'
	],
	#category : #'Bloc-Images-Elements'
}

{ #category : #layout }
BlAsyncImageElement >> applyLayoutIn: aBlBounds [

	
	super applyLayoutIn: aBlBounds.
	self queueAsyncUpdate
]

{ #category : #initialization }
BlAsyncImageElement >> clearForm [

	entry := bitmap := nil.
]

{ #category : #drawing }
BlAsyncImageElement >> drawOnSpartaCanvas: aCanvas [

	| ratio imageExtent translation form |

	super drawOnSpartaCanvas: aCanvas.
	entry ifNil: [ ^self ].
	form := entry form.

	bitmap ifNil: [ bitmap := aCanvas bitmap fromForm: form ].
	
	ratio := (self extent x / form width min: self extent y / form height) asFloat.
	imageExtent := form extent * ratio.
	translation := (((self extent x - imageExtent x ) / 2.0) @
		((self extent y - imageExtent y) / 2.0)) asIntegerPoint.

	aCanvas transform
		by: [ :t | 
			t 
				translateBy: translation;
				scaleBy: ratio
				 ]
		during: [
			aCanvas fill
				path: (0@0 extent: form extent);
				paint: bitmap;
				draw ].

]

{ #category : #accessing }
BlAsyncImageElement >> entry [ 

	^entry
]

{ #category : #accessing }
BlAsyncImageElement >> entry: aBlImageCacheEntry [
	"Set the receiver's form.
	This can be called from a background process, thus ensure the invalidation is done in the UI process"

	entry := aBlImageCacheEntry.
	bitmap := nil.
	entry ifNotNil: [ 
		self enqueueTask: (BlTaskAction new action: [ 
			self 
				removeChildren;
				invalidate ]) ]

]

{ #category : #accessing }
BlAsyncImageElement >> form [
	^entry form
]

{ #category : #testing }
BlAsyncImageElement >> needsUpdate [
	"Answer a boolean indicating whether the current form is too small or too large"

	| currentExtent formSize currentSize ratio |

	super needsUpdate ifFalse: [ ^false ].
	currentExtent := self extent.
	(currentExtent isNil or: [ currentExtent = (0@0) ]) ifTrue: [ ^false ].
	entry ifNil: [ ^true ].
	formSize := (entry form width * entry form height) asFloat.
	currentSize := (currentExtent x * currentExtent y) asFloat.
	ratio := currentSize / formSize.
	"The form needs to be reloaded if:
	- The current size is significantly smaller than the form and the form isn't the smallest available, OR
	- The current size is significantly larger than the form and the form isn't the original"
	^(ratio < 0.25 and: [ entry isSmallest not ]) or:
		[ ratio > 4 and: [ entry isOriginal not ] ]

]

{ #category : #'async processing' }
BlAsyncImageElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self queueAsyncUpdate.
]

{ #category : #'async processing' }
BlAsyncImageElement >> queueEntry [
	"Answer a kind of BlAsyncImageElementValuable that will update the receiver."

	^self subclassResponsibility

]

{ #category : #private }
BlAsyncImageElement >> setDisplayRendering [
	"Set the rendering element as a child of the receiver if the form has not already been supplied.
	This method must be evaluated within the UI process"

	entry ifNotNil: [ ^self ].
	super setDisplayRendering
]
