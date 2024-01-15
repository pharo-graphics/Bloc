Class {
	#name : #BlDevScripterAllChildrenBreadthFirstEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterAllChildrenBreadthFirstEventTarget >> findTargetIn: anElement [
	<return: #Collection of: #BlElement>

	^ Array streamContents: [ :aStream |
		anElement allChildrenBreadthFirstDo: [ :eachElement | aStream nextPut: eachElement ] ]
]

{ #category : #printing }
BlDevScripterAllChildrenBreadthFirstEventTarget >> printOn: aStream [
	aStream 
		nextPutAll: 'allChildrenBreadthFirst'
]
