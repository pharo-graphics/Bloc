Class {
	#name : 'BlNewLayoutNodeDecorationWithElement',
	#superclass : 'BlNewLayoutNodeWrapperDecoration',
	#type : 'variable',
	#instVars : [
		'element'
	],
	#category : 'Bloc-Layouts-Model-New'
}

{ #category : 'accessing' }
BlNewLayoutNodeDecorationWithElement >> element [
	^ element
]

{ #category : 'accessing' }
BlNewLayoutNodeDecorationWithElement >> element: anObject [
	element := anObject
]

{ #category : 'converting' }
BlNewLayoutNodeDecorationWithElement >> withElement: anElement [
	^ BlNewLayoutNodeDecorationWithElement new
		element: anElement;
		decoration: self decoration
]
