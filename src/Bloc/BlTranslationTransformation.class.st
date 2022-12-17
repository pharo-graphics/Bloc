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
BlTranslationTransformation class >> translation: aVector [
	^ self new translation: aVector
]

{ #category : #'instance creation' }
BlTranslationTransformation class >> x: aX y: aY z: aZ [
	^ self new
		translation: (BlVector x: aX y: aY z: aZ)
]

{ #category : #initialization }
BlTranslationTransformation >> initialize [
	super initialize.
	
	translation := BlVector zero
]

{ #category : #testing }
BlTranslationTransformation >> is2D [
	<return: #Boolean>

	^ self translation z isZero
]

{ #category : #testing }
BlTranslationTransformation >> isTranslation [
	<return: #Boolean>

	^ true
]

{ #category : #'mathematical functions' }
BlTranslationTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix translateBy: self translation
]

{ #category : #printing }
BlTranslationTransformation >> printOn: aStream [
	aStream
		nextPutAll: 'Translation by '.
		
	self translation printOn: aStream
]

{ #category : #accessing }
BlTranslationTransformation >> translation [
	<return: #BlVector>

	^ translation
]

{ #category : #accessing }
BlTranslationTransformation >> translation: aVector [
	translation := aVector asTranslate3D
]
