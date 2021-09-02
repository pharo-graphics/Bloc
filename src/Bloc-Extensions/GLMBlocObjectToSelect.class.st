"
I am an announcement that elements that are rendered by the Bloc presentation can trigger. 

"
Class {
	#name : 'GLMBlocObjectToSelect',
	#superclass : 'BlEvent',
	#instVars : [
		'toSelect',
		'fromElement'
	],
	#category : 'Bloc-Extensions'
}

{ #category : 'accessing' }
GLMBlocObjectToSelect >> fromElement [
	^ fromElement
]

{ #category : 'accessing' }
GLMBlocObjectToSelect >> fromElement: anObject [
	fromElement := anObject
]

{ #category : 'accessing' }
GLMBlocObjectToSelect >> toSelect [
	^ toSelect
]

{ #category : 'accessing' }
GLMBlocObjectToSelect >> toSelect: anObject [
	toSelect := anObject
]
