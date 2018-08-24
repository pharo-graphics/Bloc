Class {
	#name : #BlPropertyBinding,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'fromListener',
		'toListener'
	],
	#category : 'Bloc-Property'
}

{ #category : #'as yet unclassified' }
BlPropertyBinding class >> from: aFromProperty to: aToProperty [
	^ self new
		from: aFromProperty to: aToProperty;
		yourself
]

{ #category : #'as yet unclassified' }
BlPropertyBinding class >> from: aFromProperty to: aToProperty bidirectional: aBoolean [
	^ self new
		from: aFromProperty to: aToProperty bidirectional: aBoolean;
		yourself
]

{ #category : #accessing }
BlPropertyBinding >> from [
	^ from
]

{ #category : #accessing }
BlPropertyBinding >> from: aFromProperty to: aToProperty [
	self from: aFromProperty to: aToProperty bidirectional: false
]

{ #category : #'bind/unbind' }
BlPropertyBinding >> from: aFromProperty to: aToProperty bidirectional: isBidirectional [
	
	from := aFromProperty.
	to := aToProperty.
	
	fromListener := BlOnChangeListener do: [ :v | to value: v ].
	from addChangeListener: fromListener.

	isBidirectional
		ifFalse: [ ^ self ].

	toListener := BlOnChangeListener do: [ :v | from value: v ].
	to addChangeListener: toListener
]

{ #category : #accessing }
BlPropertyBinding >> to [
	^ to
]

{ #category : #'bind/unbind' }
BlPropertyBinding >> unbind [
	toListener ifNotNil: [ to removeChangeListener: toListener ].
	fromListener ifNotNil: [ from removeChangeListener: fromListener ].
	to := from := toListener := fromListener := nil
]
