Class {
	#name : 'BlNullVerticalAlignment',
	#superclass : 'BlNullAlignment',
	#category : 'Bloc-Layouts-Alignment',
	#package : 'Bloc',
	#tag : 'Layouts-Alignment'
}

{ #category : 'composition' }
BlNullVerticalAlignment >> + aHorizontalAlignment [
	^ BlCompositeAlignment horizontal: aHorizontalAlignment vertical: self
]

{ #category : 'translation' }
BlNullVerticalAlignment >> translationOf: aBounds in: aContainerBounds [
	^ 0 @ 0
]
