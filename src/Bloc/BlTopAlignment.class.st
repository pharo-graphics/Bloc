Class {
	#name : 'BlTopAlignment',
	#superclass : 'BlVerticalAlignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'class initialization' }
BlTopAlignment class >> initialize [
	super initialize.
]

{ #category : 'factory' }
BlTopAlignment class >> leftToRight [
	^ self top
]

{ #category : 'factory' }
BlTopAlignment class >> rightToLeft [
	^ self top
]

{ #category : 'factory' }
BlTopAlignment >> inverted [
	^ BlElementAlignment horizontal start
]

{ #category : 'factory' }
BlTopAlignment >> swap [
	^ BlElementAlignment bottom
]

{ #category : 'translation' }
BlTopAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>
	
	^ 0 @ (aContainerBounds top - aBounds top)
]
