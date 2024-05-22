Class {
	#name : #BlDemoMethodNode,
	#superclass : #BlDemoBasicNode,
	#category : #'Bloc-Demo-Node'
}

{ #category : #execution }
BlDemoMethodNode >> execute [
	
	| class instance |
	class := item methodClass.
	instance := class isMeta ifTrue: [ class instanceSide ] ifFalse: [ class new ].
	^ instance perform: item selector.
	"^ (class isMeta ifTrue: [ class instanceSide  perform: item selector ] ifFalse: [ class new perform: item selector ])."
	"^ item methodClass new perform: item selector"
]

{ #category : #accessing }
BlDemoMethodNode >> icon [

	^ #glamorousGrayCircle
]

{ #category : #accessing }
BlDemoMethodNode >> name [ 
	^ self selector
]

{ #category : #accessing }
BlDemoMethodNode >> selector [ 
	^ item selector
]

{ #category : #accessing }
BlDemoMethodNode >> sourceCode [ 
	^ item sourceCode
]
