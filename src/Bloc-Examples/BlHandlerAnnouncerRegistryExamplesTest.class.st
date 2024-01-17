"
I contain examples of event handler registry with Announcer as its backend

"
Class {
	#name : 'BlHandlerAnnouncerRegistryExamplesTest',
	#superclass : 'TestCase',
	#traits : 'TBlHandlerRegistryExamples',
	#classTraits : 'TBlHandlerRegistryExamples classTrait',
	#category : 'Bloc-Examples-EventHandling',
	#package : 'Bloc-Examples',
	#tag : 'EventHandling'
}

{ #category : 'instance creation' }
BlHandlerAnnouncerRegistryExamplesTest >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ BlHandlerAnnouncerRegistry new
]
