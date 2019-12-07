Class {
	#name : #BlDevScripterTask,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #printing }
BlDevScripterTask >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #'gt-extension' }
BlDevScripterTask >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #accessing }
BlDevScripterTask >> label [
	^ 'Task'
]

{ #category : #'gt-extension' }
BlDevScripterTask >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			(each isKindOf: BlDevScripterCompositeTask) not
				ifTrue: [
					BlTextElement new 
						zIndex: 10;
						background: Color white;
						constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
						text: (each gtDisplayString asRopedText) ]
				ifFalse: [ 
					BlElement new 
						when: BlClickEvent do: [ :event | event target phlow spawnObject: each ];
						zIndex: 10;
						geometry: BlEllipse new;
						border: (BlBorder paint: Color black width: 1);
						background: (Color white);
						size: 10@10 ] ];
		with: (self withDeepCollect: #tasks).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #tasks.
	view layout custom: (GtGradNorthHierarchicalLayout new)
]

{ #category : #actions }
BlDevScripterTask >> playOn: aScripter [
	
]

{ #category : #accessing }
BlDevScripterTask >> tasks [
	^ #()
]
