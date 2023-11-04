"
I contain examples of event handler registry with Array as its backend

"
Class {
	#name : 'BlHandlerArrayRegistryExamples',
	#superclass : 'BlExampleTest',
	#traits : 'TBlHandlerRegistryExamples',
	#classTraits : 'TBlHandlerRegistryExamples classTrait',
	#category : 'Bloc-Examples-EventHandling',
	#package : 'Bloc-Examples',
	#tag : 'EventHandling'
}

{ #category : 'instance creation' }
BlHandlerArrayRegistryExamples >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ BlHandlerArrayRegistry new
]
