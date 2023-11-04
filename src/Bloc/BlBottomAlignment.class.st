Class {
	#name : 'BlBottomAlignment',
	#superclass : 'BlVerticalAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'class initialization' }
BlBottomAlignment class >> initialize [
	super initialize.
]

{ #category : 'factory' }
BlBottomAlignment class >> leftToRight [
	^ self bottom
]

{ #category : 'factory' }
BlBottomAlignment class >> rightToLeft [
	^ self bottom
]

{ #category : 'factory' }
BlBottomAlignment >> inverted [
	^ BlElementAlignment horizontal end
]

{ #category : 'factory' }
BlBottomAlignment >> swap [
	^ BlElementAlignment top
]

{ #category : 'translation' }
BlBottomAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>
	
	^ 0 @ (aContainerBounds height - aBounds height + aContainerBounds top - aBounds top)
]
