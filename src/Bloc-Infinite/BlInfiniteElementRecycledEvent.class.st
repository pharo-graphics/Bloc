"
Sent when the element in the ElementHolder is recycled.
Recycler sends me right before clearing ElementHolder's internal data and sending it to RecyclerPool. This way, if ElementHolder was holding valid information before being recycled, you can use ===#dataSourcePosition=== to get its datasource position.

Sent by:
  - BlInfiniteRecycler

Example:

infiniteElement recycler
	addEventHandlerOn: BlInfiniteElementRecycledEvent
	do: [ :event | self inform: ('Recycled: ', event holder dataSourcePosition asString)]
"
Class {
	#name : #BlInfiniteElementRecycledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder'
	],
	#category : 'Bloc-Infinite-Events'
}

{ #category : #accessing }
BlInfiniteElementRecycledEvent class >> holder: anElementHolder [
	^ self new
		holder: anElementHolder;
		yourself
]

{ #category : #accessing }
BlInfiniteElementRecycledEvent >> holder [
	^ holder
]

{ #category : #accessing }
BlInfiniteElementRecycledEvent >> holder: anObject [
	holder := anObject
]
