Class {
	#name : #BlNullVerticalAlignment,
	#superclass : #BlNullAlignment,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #composition }
BlNullVerticalAlignment >> + aHorizontalAlignment [
	^ BlCompositeAlignment horizontal: aHorizontalAlignment vertical: self
]

{ #category : #translation }
BlNullVerticalAlignment >> translationOf: aBounds in: aContainerBounds [
	^ 0 @ 0
]
