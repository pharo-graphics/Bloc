Class {
	#name : #BlHorizontalAlignment,
	#superclass : #BlElementAlignment,
	#classInstVars : [
		'center',
		'left',
		'right'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #factory }
BlHorizontalAlignment class >> center [
	^ center
]

{ #category : #factory }
BlHorizontalAlignment class >> directed: aBlLayoutDirection [
	^ aBlLayoutDirection of: self
]

{ #category : #'class initialization' }
BlHorizontalAlignment class >> initialize [
	super initialize.
	
	left := BlLeftAlignment new.
	right := BlRightAlignment new.
	center := BlHorizontalCenterAlignment new.
	start := BlHorizontalStartAlignment new.
	end := BlHorizontalEndAlignment new.
]

{ #category : #factory }
BlHorizontalAlignment class >> left [
	^ left
]

{ #category : #factory }
BlHorizontalAlignment class >> leftToRight [
	^ self subclassResponsibility
]

{ #category : #factory }
BlHorizontalAlignment class >> null [
	^ BlElementAlignment null horizontal
]

{ #category : #factory }
BlHorizontalAlignment class >> right [
	^ right
]

{ #category : #factory }
BlHorizontalAlignment class >> rightToLeft [
	^ self subclassResponsibility
]

{ #category : #composition }
BlHorizontalAlignment >> + aVerticalAlignment [
	^ BlCompositeAlignment horizontal: self vertical: aVerticalAlignment
]

{ #category : #factory }
BlHorizontalAlignment >> center [
	^ self class center
]

{ #category : #factory }
BlHorizontalAlignment >> directed: aBlLayoutDirection [
	^ self class directed: aBlLayoutDirection
]

{ #category : #factory }
BlHorizontalAlignment >> end [
	^ self class end
]

{ #category : #factory }
BlHorizontalAlignment >> leftToRight [
	^ self class leftToRight
]

{ #category : #factory }
BlHorizontalAlignment >> null [
	^ self class null
]

{ #category : #factory }
BlHorizontalAlignment >> rightToLeft [
	^ self class rightToLeft
]

{ #category : #factory }
BlHorizontalAlignment >> start [
	^ self class start
]
