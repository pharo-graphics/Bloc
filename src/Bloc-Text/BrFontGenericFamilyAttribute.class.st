Class {
	#name : #BrFontGenericFamilyAttribute,
	#superclass : #BrTextAttribute,
	#instVars : [
		'family'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute class >> monospace [
	^ self new
		monospace;
		yourself
]

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute class >> sansSerif [
	^ self new
		sansSerif;
		yourself
]

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute class >> serif [
	^ self new
		serif;
		yourself
]

{ #category : #comparing }
BrFontGenericFamilyAttribute >> equals: aTextAttribute [
	^ self family = aTextAttribute family
]

{ #category : #accessing }
BrFontGenericFamilyAttribute >> family [
	^ family
]

{ #category : #comparing }
BrFontGenericFamilyAttribute >> hash [
	^ self class hash bitXor: self family hash
]

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute >> monospace [
	family := #monospace
]

{ #category : #printing }
BrFontGenericFamilyAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-family: ';
		nextPutAll: self family
]

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute >> sansSerif [
	family := #sansSerif
]

{ #category : #'instance creation' }
BrFontGenericFamilyAttribute >> serif [
	family := #serif
]
