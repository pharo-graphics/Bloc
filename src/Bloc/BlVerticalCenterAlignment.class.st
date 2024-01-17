Class {
	#name : 'BlVerticalCenterAlignment',
	#superclass : 'BlVerticalAlignment',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'class initialization' }
BlVerticalCenterAlignment class >> initialize [

	self initializeSingletons
]

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
