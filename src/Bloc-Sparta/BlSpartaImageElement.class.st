"
BlSpartaImageElement displays a single image from an encoded source, either a file name or buffer containing the encoded image.  Supported formats depend on the back-end, but typically include jpeg, png, etc.

Generating the child element is deferred until the element is first drawn so that the specific back-end can be used to generate the child element.

As the content is generated after the element tree is constructed, decoding errors won't be detected until display time.  See TBlElementError for how exceptions are handled.

A BlSpartaImage only ever has one child, the back-end specific element for displaying the image or an element displaying an error.

!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	image:		<BlElement>


!!!Implementation Points
"
Class {
	#name : #BlSpartaImageElement,
	#superclass : #BlElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'image'
	],
	#category : #'Bloc-Sparta-Elements'
}

{ #category : #drawing }
BlSpartaImageElement >> drawOnSpartaCanvas: aCanvas [

	image ifNil: 
		[ image := (self getImageWith: aCanvas) asElement.
		image constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
		self addChild: image ].
	super drawOnSpartaCanvas: aCanvas.

]

{ #category : #private }
BlSpartaImageElement >> getImageWith: aCanvas [
	"Get the appropriate back-end specific image to display"

	^ self subclassResponsibility 
]
