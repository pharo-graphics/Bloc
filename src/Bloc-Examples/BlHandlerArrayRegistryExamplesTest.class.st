"
I contain examples of event handler registry with Array as its backend

"
Class {
	#name : 'BlHandlerArrayRegistryExamplesTest',
	#superclass : 'TestCase',
	#traits : 'TBlHandlerRegistryExamples',
	#classTraits : 'TBlHandlerRegistryExamples classTrait',
	#category : 'Bloc-Examples-EventHandling',
	#package : 'Bloc-Examples',
	#tag : 'EventHandling'
}

{ #category : 'instance creation' }
BlHandlerArrayRegistryExamplesTest >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ BlHandlerArrayRegistry new
]
