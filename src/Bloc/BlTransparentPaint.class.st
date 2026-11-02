"
I am deprecated. Use `BlPaint transparent` (or `BlColorPaint transparent`) instead.
"
Class {
	#name : #BlTransparentPaint,
	#superclass : #BlColorPaint,
	#category : #'Bloc-Paint'
}

{ #category : #testing }
BlTransparentPaint class >> isDeprecated [

	^ true
]

{ #category : #'instance creation' }
BlTransparentPaint class >> new [

	self
		deprecated: 'Use BlPaint transparent instead'
		transformWith: '`@receiver new' -> 'BlPaint transparent'.

	^ BlColorPaint transparent
]

{ #category : #accessing }
BlTransparentPaint class >> uniqueInstance [

	self
		deprecated: 'Use BlPaint transparent instead'
		transformWith: '`@receiver uniqueInstance' -> 'BlPaint transparent'.

	^ BlColorPaint transparent
]

{ #category : #initialization }
BlTransparentPaint >> initialize [

	super initialize.

	color := Color transparent
]
