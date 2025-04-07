Class {
	#name : #BlDemoScript,
	#superclass : #ClyClassScript,
	#category : #'Bloc-DevTool-Calypso'
}

{ #category : #'script detection' }
BlDemoScript class >> isImplementedByMethod: method [

	^ method hasPragmaNamed: #demo
]

{ #category : #accessing }
BlDemoScript >> description [

	^ 'Open the demo'
]

{ #category : #execution }
BlDemoScript >> executeOn: class [

 	(super executeOn: class)
		openInSpace
]

{ #category : #accessing }
BlDemoScript >> iconName [

	^ #smallDoIt
]
