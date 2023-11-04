"
I am a very basic layout that supports very simple measurement and positions elements according to their #position attribute, which means that I never change actual location (position) of children within parent with basic layout.

"
Class {
	#name : 'BlBasicLayout',
	#superclass : 'BlLayout',
	#classInstVars : [
		'uniqueInstance'
	],
	#package : 'Bloc',
	#tag : 'Layouts-Basic'
}

{ #category : 'accessing' }
BlBasicLayout class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlBasicLayout class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'layout' }
BlBasicLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	anElement children accountedByLayout do: [ :child |
		| childLayoutBounds |
		childLayoutBounds := child constraints position extent: child measuredExtent.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdater ].

	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : 'measure' }
BlBasicLayout >> measure: anElement with: anExtentSpec [
	super measure: anElement with: anExtentSpec.
	
	self measureIgnored: anElement with: anExtentSpec
]
