Class {
	#name : #BlDemoClassNode,
	#superclass : #BlDemoBasicNode,
	#category : #'Bloc-Demo-Node'
}

{ #category : #accessing }
BlDemoClassNode >> icon [

	^ #class
]

{ #category : #accessing }
BlDemoClassNode >> methods [ 
	^ item methods
]
