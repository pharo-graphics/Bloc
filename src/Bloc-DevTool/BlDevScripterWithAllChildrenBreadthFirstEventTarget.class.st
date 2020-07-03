Class {
	#name : #BlDevScripterWithAllChildrenBreadthFirstEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterWithAllChildrenBreadthFirstEventTarget >> findTargetIn: anElement [
	<return: #Collection of: #BlElement>

	^ anElement withAllChildrenBreadthFirst
]

{ #category : #printing }
BlDevScripterWithAllChildrenBreadthFirstEventTarget >> printOn: aStream [
	aStream 
		nextPutAll: 'withAllChildrenBreadthFirst'
]
