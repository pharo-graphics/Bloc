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
		'preLoad'
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

	entry := nil.
]

{ #category : #drawing }
BlAsyncImageElement >> drawOnSpartaCanvas: aCanvas [

	| ratio imageExtent translation image |

	super drawOnSpartaCanvas: aCanvas.
	entry ifNil: [ ^self ].
	image := entry image.

	ratio := (self extent x / image width min: self extent y / image height) asFloat.
	imageExtent := image extent * ratio.
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
				path: (0@0 extent: image extent);
				paint: image;
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

	| cache currentExtent imageSize currentSize noExtent |

	asyncException ifNotNil: [ ^false ].
	currentExtent := self extent.
	noExtent := currentExtent isNil or: [ currentExtent = (0@0) ].
	"If not pre-loading, and the image is zero size, no need to update"
	(preLoad isNil and: [ noExtent ]) ifTrue: [ ^false ].
	entry ifNil: [ ^true ].
	noExtent ifTrue: [ ^false ].

	imageSize := entry image extent max.
	currentSize := currentExtent max.
	"The image needs to be reloaded if the image cache would use a different entry"
	cache := BlLocalImageCache current.
	^ (cache cacheSizeFor: imageSize) ~= (cache cacheSizeFor: currentSize).

]

{ #category : #accessing }
BlAsyncImageElement >> preLoad [
	^ preLoad
]

{ #category : #accessing }
BlAsyncImageElement >> preLoad: anObject [
	preLoad := anObject
]

{ #category : #'async processing' }
BlAsyncImageElement >> queueEntry [
	"Answer a kind of BlAsyncImageElementValuable that will update the receiver."

	^self subclassResponsibility

]

{ #category : #private }
BlAsyncImageElement >> schedulePreview [
	"Set the rendering element as a child of the receiver if the form has not already been supplied.
	This method must be evaluated within the UI process"

	entry ifNotNil: [ ^ self ].
	super schedulePreview
]
