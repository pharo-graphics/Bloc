Class {
	#name : #BlRelativeAlignment,
	#superclass : #BlElementAlignment,
	#category : 'Bloc-Layouts-Alignment'
}

{ #category : 'factory' }
BlRelativeAlignment class >> horizontal [
	^ self subclassResponsibility
]

{ #category : 'factory' }
BlRelativeAlignment class >> oriented: aBlLayoutOrientation [
	^ aBlLayoutOrientation of: self
]

{ #category : 'factory' }
BlRelativeAlignment class >> vertical [
	^ self subclassResponsibility
]

{ #category : 'factory' }
BlRelativeAlignment >> horizontal [
	^ self class horizontal
]

{ #category : 'factory' }
BlRelativeAlignment >> oriented: aBlLayoutOrientation [
	^ self class oriented: aBlLayoutOrientation
]

{ #category : 'factory' }
BlRelativeAlignment >> vertical [
	^ self class vertical
]
