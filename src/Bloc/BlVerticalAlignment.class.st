Class {
	#name : #BlVerticalAlignment,
	#superclass : #BlElementAlignment,
	#classInstVars : [
		'bottom',
		'center',
		'top'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #factory }
BlVerticalAlignment class >> bottom [
	^ bottom
]

{ #category : #factory }
BlVerticalAlignment class >> center [
	^ center
]

{ #category : #factory }
BlVerticalAlignment class >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : #factory }
BlVerticalAlignment class >> end [
	^ self bottom
]

{ #category : #'class initialization' }
BlVerticalAlignment class >> initialize [
	super initialize.
	
	top := BlTopAlignment new.
	center := BlVerticalCenterAlignment new.
	bottom := BlBottomAlignment new
]

{ #category : #factory }
BlVerticalAlignment class >> leftToRight [
	^ self subclassResponsibility
]

{ #category : #factory }
BlVerticalAlignment class >> null [
	^ BlElementAlignment null vertical
]

{ #category : #factory }
BlVerticalAlignment class >> rightToLeft [
	^ self subclassResponsibility
]

{ #category : #factory }
BlVerticalAlignment class >> start [
	^ self top
]

{ #category : #factory }
BlVerticalAlignment class >> top [
	^ top
]

{ #category : #composition }
BlVerticalAlignment >> + aHorizontalAlignment [
	^ BlCompositeAlignment horizontal: aHorizontalAlignment vertical: self
]

{ #category : #factory }
BlVerticalAlignment >> center [
	^ self class center
]

{ #category : #factory }
BlVerticalAlignment >> directed: aBlLayoutDirection [
	^ self class directed: aBlLayoutDirection
]

{ #category : #factory }
BlVerticalAlignment >> end [
	^ self class end
]

{ #category : #factory }
BlVerticalAlignment >> leftToRight [
	^ self class leftToRight
]

{ #category : #factory }
BlVerticalAlignment >> null [
	^ self class null
]

{ #category : #factory }
BlVerticalAlignment >> rightToLeft [
	^ self class rightToLeft
]

{ #category : #factory }
BlVerticalAlignment >> start [
	^ self class start
]
