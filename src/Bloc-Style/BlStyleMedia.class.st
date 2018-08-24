Class {
	#name : #BlStyleMedia,
	#superclass : #Object,
	#instVars : [
		'conditions',
		'rules',
		'stylesheet'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'adding/removing' }
BlStyleMedia >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet medias add: self
]

{ #category : #'as yet unclassified' }
BlStyleMedia >> computedStyles [
	
]

{ #category : #accessing }
BlStyleMedia >> conditions [
	^ conditions
]

{ #category : #accessing }
BlStyleMedia >> conditions: aCollection [
	aCollection
		do: [ :item | 
			item media: self.
			self conditions add: item ]
]

{ #category : #'initialize-release' }
BlStyleMedia >> initialize [
	super initialize.
	conditions := OrderedCollection new.
	rules := OrderedCollection new
]

{ #category : #accessing }
BlStyleMedia >> rules [
	^ rules
]

{ #category : #accessing }
BlStyleMedia >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
BlStyleMedia >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
BlStyleMedia >> stylesheet: anObject [
	stylesheet := anObject
]
