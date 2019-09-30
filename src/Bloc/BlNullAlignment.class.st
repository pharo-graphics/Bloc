"
I represent null alignment which is default one.
See BlLayoutAlignment for more info.
"
Class {
	#name : #BlNullAlignment,
	#superclass : #BlElementAlignment,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'class initialization' }
BlNullAlignment class >> initialize [
	super initialize.
	
	vertical := BlNullVerticalAlignment new.
	horizontal := BlNullHorizontalAlignment new.
]

{ #category : #factory }
BlNullAlignment >> directed: aBlLayoutDirection [
	^ self
]

{ #category : #factory }
BlNullAlignment >> horizontal [
	^ self class horizontal
]

{ #category : #testing }
BlNullAlignment >> ifNotNull: aBlock [
	"nothing"
]

{ #category : #testing }
BlNullAlignment >> ifNull: aBlock [
	aBlock value
]

{ #category : #factory }
BlNullAlignment >> leftToRight [
	^ self
]

{ #category : #factory }
BlNullAlignment >> oriented: aBlLayoutOrientation [
	^ self
]

{ #category : #factory }
BlNullAlignment >> rightToLeft [
	^ self
]

{ #category : #factory }
BlNullAlignment >> vertical [
	^ self class vertical
]
