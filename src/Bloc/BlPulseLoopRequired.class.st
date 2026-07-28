"
I am a dynamic variable that controls whether hosts should spawn and start their background pulse loop process.

By default, I return `true`. However, test environments (such as `BlParameterizedHostTest`) dynamically bind me to `false` during test execution to prevent background threads from running. This allows tests to run deterministically and synchronously on a single thread.
"
Class {
	#name : #BlPulseLoopRequired,
	#superclass : #DynamicVariable,
	#category : #'Bloc-Space'
}

{ #category : #accessing }
BlPulseLoopRequired >> default [

	^ true
]
