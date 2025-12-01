Class {
	#name : #BlDemoClassNode,
	#superclass : #BlDemoBasicNode,
	#category : #'Bloc-Demo-DemoPresenterNodes'
}

{ #category : #accessing }
BlDemoClassNode >> icon [

	^ #class
]

{ #category : #accessing }
BlDemoClassNode >> methods [ 
	^ item methods
]
