"
Specifies a translation by the vector (x, y, z).

Corresponds to SVG translate() function
https://drafts.csswg.org/css-transforms/#valdef-transform-translate

"
Class {
	#name : #BlTranslationTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'translation'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlTranslationTransformation class >> translation: aBlVector [

	^ self new
		  translation: aBlVector;
		  yourself
]

{ #category : #'instance creation' }
BlTranslationTransformation class >> x: aX y: aY z: aZ [

	^ self new
		  translation: (BlVector x: aX y: aY z: aZ);
		  yourself
]

{ #category : #comparing }
BlTranslationTransformation >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [^ false ].
	^ self translation = anObject translation
]

{ #category : #initialization }
BlTranslationTransformation >> initialize [

	super initialize.

	translation := BlVector zero
]

{ #category : #testing }
BlTranslationTransformation >> is2D [

	^ translation z isZero
]

{ #category : #testing }
BlTranslationTransformation >> isTranslation [

	^ true
]

{ #category : #'mathematical functions' }
BlTranslationTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix translateBy: translation
]

{ #category : #printing }
BlTranslationTransformation >> printOn: aStream [

	aStream nextPutAll: 'Translation by '.

	translation printOn: aStream
]

{ #category : #accessing }
BlTranslationTransformation >> translation [

	^ translation
]

{ #category : #accessing }
BlTranslationTransformation >> translation: aVector [

	translation := aVector asTranslate3D
]
