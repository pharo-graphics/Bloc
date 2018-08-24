Class {
	#name : #BlMatchedRule,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declarations',
		'transitions',
		'conditions'
	],
	#classVars : [
		'AkStyleTransition'
	],
	#category : 'Bloc-Style-Util'
}

{ #category : #'as yet unclassified' }
BlMatchedRule >> computedStyles [
	^ self declarations
		collect: [ :d | 
			BlStyle new
				selector: self selector;
				declaration: d;
				conditions: self conditions;
				yourself ]
]

{ #category : #'as yet unclassified' }
BlMatchedRule >> computedTransitions [
	^ self transitions
		collect: [ :t | BlStyleTransition new
				selector: self selector;
				transition: t;
				yourself ]
]

{ #category : #accessing }
BlMatchedRule >> conditions [
	^ conditions
]

{ #category : #accessing }
BlMatchedRule >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
BlMatchedRule >> declarations [
	^ declarations
]

{ #category : #accessing }
BlMatchedRule >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
BlMatchedRule >> selector [
	^ selector
]

{ #category : #accessing }
BlMatchedRule >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
BlMatchedRule >> specificity [
	^ selector specificity
]

{ #category : #accessing }
BlMatchedRule >> transitions [
	^ transitions
]

{ #category : #accessing }
BlMatchedRule >> transitions: anObject [
	transitions := anObject
]
