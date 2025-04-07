"
`BlElement>>#forceLayout` shouild not be manually invoked as exaplained by the followoing comment:


**forceLayout**
	""Do not use me, I am a private / debug utility method to force layout computation.
	The main usage of this method is for testing purposes where we want to update layout
	without the need to create a separate space and add an element to it in order to test bounds or position.
	Note: because layout measurement may depend on other element it is mandatory to compute
	layout going down from the top most parent, otherwise layout will not be valid""

"
Class {
	#name : #ReBlocDoNotSendForceLayoutRule,
	#superclass : #ReAbstractRule,
	#category : #'Bloc-Rules'
}

{ #category : #testing }
ReBlocDoNotSendForceLayoutRule class >> checksMethod [

	^ true
]

{ #category : #accessing }
ReBlocDoNotSendForceLayoutRule class >> uniqueIdentifierName [
	"This number should be unique and should change only when the rule completely change semantics"

	^ 'BlocDoNotSendForceLayout'
]

{ #category : #running }
ReBlocDoNotSendForceLayoutRule >> basicCheck: aMethod [

	^ (aMethod sendsSelector: #forceLayout)
]

{ #category : #accessing }
ReBlocDoNotSendForceLayoutRule >> group [
	^ 'Potential Bugs'
]

{ #category : #accessing }
ReBlocDoNotSendForceLayoutRule >> name [

	^ 'Do not send forceLayout'
]
