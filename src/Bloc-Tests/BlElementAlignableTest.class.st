Class {
	#name : #BlElementAlignableTest,
	#superclass : #BlElement,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#category : 'Bloc-Tests-Layouts-Alignment'
}

{ #category : #accessing }
BlElementAlignableTest >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment
]

{ #category : #accessing }
BlElementAlignableTest >> horizontalAlignment: aBlElementAlignment [
	
	self layout horizontalAlignment: aBlElementAlignment
]

{ #category : #accessing }
BlElementAlignableTest >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment
]

{ #category : #accessing }
BlElementAlignableTest >> verticalAlignment: aBlElementAlignment [
	
	self layout verticalAlignment: aBlElementAlignment
]
