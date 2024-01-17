Class {
	#name : 'BlVerticalCenterAlignment',
	#superclass : 'Object',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'factory' }
BlVerticalCenterAlignment class >> leftToRight [
	^ self center
]

{ #category : 'factory' }
BlVerticalCenterAlignment class >> rightToLeft [
	^ self center
]

{ #category : 'factory' }
BlVerticalCenterAlignment >> inverted [
	^ BlElementAlignment horizontal center
]

{ #category : 'factory' }
BlVerticalCenterAlignment >> swap [
	^ self
]

{ #category : 'translation' }
BlVerticalCenterAlignment >> translationOf: aBounds in: aContainerBounds [
	<return: #Point>
	
	^ 0 @ ((aContainerBounds height - aBounds height) / 2.0 + aContainerBounds top - aBounds top)
]
