Class {
	#name : #BlElementMaybeResolvedProperties,
	#superclass : #BlElementProperties,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #actions }
BlElementMaybeResolvedProperties >> applyOnElement: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
BlElementMaybeResolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock [
	^ self 
		propertyAt: aPropertyType
		ifFound: aFoundBlock
		ifNone: [ nil ]
]

{ #category : #accessing }
BlElementMaybeResolvedProperties >> propertyAt: aPropertyType ifFound: aFoundBlock ifNone: aNoneBlock [
	self subclassResponsibility
]

{ #category : #accessing }
BlElementMaybeResolvedProperties >> propertyAt: aPropertyType ifNone: aNoneBlock [
	^ self 
		propertyAt: aPropertyType
		ifFound: [ :aProperty | aProperty ]
		ifNone: aNoneBlock
]
