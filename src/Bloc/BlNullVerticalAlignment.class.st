Class {
	#name : #BlNullVerticalAlignment,
	#superclass : #BlNullAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : #'class initialization' }
BlNullVerticalAlignment class >> initialize [

	self initializeSingletons
]

{ #category : #composition }
BlNullVerticalAlignment >> + aHorizontalAlignment [
	^ BlCompositeAlignment horizontal: aHorizontalAlignment vertical: self
]

{ #category : #translation }
BlNullVerticalAlignment >> translationOf: aBounds in: aContainerBounds [
	^ 0 @ 0
]
