"
I am a very basic layout that supports very simple measurement and positions elements according to their #position attribute, which means that I never change actual location (position) of children within parent with basic layout.
"
Class {
	#name : #BlBasicLayout,
	#superclass : #BlLayout,
	#category : 'Bloc-Layouts-Basic'
}

{ #category : #layout }
BlBasicLayout >> layout: anElement in: aRectangle [

	anElement children accountedByLayout do: [ :child |
		child applyLayoutIn: child measuredBounds asRectangle ].

	self layoutIgnored: anElement
]

{ #category : #measure }
BlBasicLayout >> measure: anElement with: anExtentSpec [
	super measure: anElement with: anExtentSpec.
	
	self measureIgnored: anElement with: anExtentSpec
]
