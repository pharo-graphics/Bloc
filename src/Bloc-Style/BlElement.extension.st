Extension { #name : #BlElement }

{ #category : #'*Bloc-Style' }
BlElement >> addStyleClass: anObject [
	self styleClasses add: anObject.
]

{ #category : #'*Bloc-Style' }
BlElement >> addStylesheet: anObject [
	self stylesheets add: anObject.
]

{ #category : #'*Bloc-Style' }
BlElement >> defaultStyler [
	^ BlElementStyler on: self
]

{ #category : #'*Bloc-Style' }
BlElement >> pseudoClassStates [
	^ self styler pseudoClassStates
]

{ #category : #'*Bloc-Style' }
BlElement >> removeStyleClass: anObject [
	self styleClasses remove:anObject
]

{ #category : #'*Bloc-Style' }
BlElement >> styleClass [
	^ self styleClasses first
]

{ #category : #'*Bloc-Style' }
BlElement >> styleClass: anObject [
	self styleClasses: {anObject}
]

{ #category : #'*Bloc-Style' }
BlElement >> styleClasses [
	^ self styler styleClasses
]

{ #category : #'*Bloc-Style' }
BlElement >> styleClasses: aCollection [
	self styler styleClasses: aCollection
]

{ #category : #'*Bloc-Style' }
BlElement >> styleId [
	^ self styler styleId
]

{ #category : #'*Bloc-Style' }
BlElement >> styleId: anObject [
	self styler styleId:anObject
]

{ #category : #'*Bloc-Style' }
BlElement >> styler [
	^ styler ifNil: [ styler := self defaultStyler ]
]

{ #category : #'*Bloc-Style' }
BlElement >> styler: aStyler [
	styler := aStyler
]

{ #category : #'*Bloc-Style' }
BlElement >> stylesheets [
	^ self styler stylesheets
]
