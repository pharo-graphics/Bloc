"
In Bloc an element defines a width method. Redefining it can lead to difficult to spot bugs.
"
Class {
	#name : #ReBlocWidthShouldNotBeOverriddenRule,
	#superclass : #ReAbstractRule,
	#category : #'Bloc-Rules'
}

{ #category : #testing }
ReBlocWidthShouldNotBeOverriddenRule class >> checksMethod [

	^ true
]

{ #category : #accessing }
ReBlocWidthShouldNotBeOverriddenRule class >> uniqueIdentifierName [
	"This number should be unique and should change only when the rule completely change semantics"

	^ 'BlocWidth'
]

{ #category : #running }
ReBlocWidthShouldNotBeOverriddenRule >> basicCheck: aMethod [

	^ (aMethod methodClass inheritsFrom: BlElement) and: [
		  aMethod methodClass includesSelector: #width ]
]

{ #category : #accessing }
ReBlocWidthShouldNotBeOverriddenRule >> group [
	^ 'Potential Bugs'
]

{ #category : #accessing }
ReBlocWidthShouldNotBeOverriddenRule >> name [

	^ 'Width should not be overridden'
]
