Class {
	#name : #BlStyleOrigin,
	#superclass : #Object,
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStyleOrigin class >> AUTHOR [
	^ BlStyleAuthorOrigin
]

{ #category : #'as yet unclassified' }
BlStyleOrigin class >> INLINE [
	^ BlStyleInlineOrigin
]

{ #category : #'as yet unclassified' }
BlStyleOrigin class >> USER [
	^ BlStyleUserOrigin
]

{ #category : #'as yet unclassified' }
BlStyleOrigin class >> USER_AGENT [
	^ BlStyleUserAgentOrigin
]
