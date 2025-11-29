Class {
	#name : #BlDemoMethodNode,
	#superclass : #BlDemoBasicNode,
	#category : #'Bloc-Demo-Node'
}

{ #category : #execution }
BlDemoMethodNode >> execute [

	| methodClass instance |
	methodClass := item methodClass.
	instance := methodClass isMeta 
		ifTrue: [ methodClass soleInstance ] 
		ifFalse: [ methodClass new ].
	^ instance perform: item selector
]

{ #category : #accessing }
BlDemoMethodNode >> icon [

	^ #glamorousGrayCircle
]

{ #category : #accessing }
BlDemoMethodNode >> name [ 
	^ self selector
]

{ #category : #printing }
BlDemoMethodNode >> printOn: aStream [

	super printOn: aStream.
	aStream space ; print: item 
	
]

{ #category : #accessing }
BlDemoMethodNode >> selector [ 
	^ item selector
]

{ #category : #accessing }
BlDemoMethodNode >> sourceCode [ 
	^ item sourceCode
]
