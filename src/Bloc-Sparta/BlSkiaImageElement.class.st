"
BlSkiaImageElement can be used to directly display a SkiaImage in Bloc.

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	image:		<SkiaImage>


!!!Implementation Points
"
Class {
	#name : #BlSkiaImageElement,
	#superclass : #BlElement,
	#instVars : [
		'image'
	],
	#category : #'Bloc-Sparta-Elements'
}

{ #category : #drawing }
BlSkiaImageElement >> drawOnSpartaCanvas: aCanvas [

	| ratio imageExtent translation |

	super drawOnSpartaCanvas: aCanvas.
	image ifNil: [ ^self ].

	ratio := (self extent x / image width min: self extent y / image height) asFloat.
	imageExtent := image extent * ratio.
	translation := (((self extent x - imageExtent x ) / 2.0) @
		((self extent y - imageExtent y) / 2.0)) asIntegerPoint.

	aCanvas transform
		by: [ :t | 
			t translateBy: translation.
			ratio isZero ifFalse: [
				t scaleBy: ratio ].
				 ]
		during: [
			aCanvas fill
				path: (0@0 extent: image extent);
				paint: image;
				draw ].

]

{ #category : #accessing }
BlSkiaImageElement >> image [
	^ image
]

{ #category : #accessing }
BlSkiaImageElement >> image: anObject [
	image := anObject
]
