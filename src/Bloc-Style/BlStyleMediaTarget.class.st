Class {
	#name : #BlStyleMediaTarget,
	#superclass : #Object,
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStyleMediaTarget class >> defaultOn: aTarget [
	^ aTarget
]

{ #category : #'as yet unclassified' }
BlStyleMediaTarget class >> screenOn: aTarget [
	^ aTarget space root
]
