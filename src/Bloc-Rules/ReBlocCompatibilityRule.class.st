"
Delete when we drop support on Pharo 12. 

See: https://github.com/pharo-graphics/Bloc/issues/791
"
Class {
	#name : #ReBlocCompatibilityRule,
	#superclass : #ReAbstractRule,
	#category : #'Bloc-Rules'
}

{ #category : #accessing }
ReBlocCompatibilityRule >> group [
	
	self flag: #todo. "See: https://github.com/pharo-graphics/Bloc/issues/791"
	
	^ self class group
]

{ #category : #accessing }
ReBlocCompatibilityRule >> name [

	self flag: #todo. "See: https://github.com/pharo-graphics/Bloc/issues/791"

	^ self class ruleName
]

{ #category : #accessing }
ReBlocCompatibilityRule >> ruleName [
	
	self flag: #todo. "See: https://github.com/pharo-graphics/Bloc/issues/791"

	^ self class ruleName
]
