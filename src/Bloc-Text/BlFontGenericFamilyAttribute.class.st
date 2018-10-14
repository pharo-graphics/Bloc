Class {
	#name : #BlFontGenericFamilyAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'family'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute class >> monospace [
	^ self new
		monospace;
		yourself
]

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute class >> sansSerif [
	^ self new
		sansSerif;
		yourself
]

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute class >> serif [
	^ self new
		serif;
		yourself
]

{ #category : #comparing }
BlFontGenericFamilyAttribute >> equals: aTextAttribute [
	^ self family = aTextAttribute family
]

{ #category : #accessing }
BlFontGenericFamilyAttribute >> family [
	^ family
]

{ #category : #comparing }
BlFontGenericFamilyAttribute >> hash [
	^ self class hash bitXor: self family hash
]

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute >> monospace [
	family := #monospace
]

{ #category : #printing }
BlFontGenericFamilyAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self family
]

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute >> sansSerif [
	family := #sansSerif
]

{ #category : #'instance creation' }
BlFontGenericFamilyAttribute >> serif [
	family := #serif
]
