Class {
	#name : #BlDemoMethodNode,
	#superclass : #BlDemoBasicNode,
	#category : #'Bloc-Demo-Node'
}

{ #category : #execution }
BlDemoMethodNode >> execute [
	
	
	^ item methodClass new perform: item selector
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
