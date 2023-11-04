"
I contain examples of event handler registry with Announcer as its backend

"
Class {
	#name : 'BlHandlerAnnouncerRegistryExamples',
	#superclass : 'BlExampleTest',
	#traits : 'TBlHandlerRegistryExamples',
	#classTraits : 'TBlHandlerRegistryExamples classTrait',
	#category : 'Bloc-Examples-EventHandling',
	#package : 'Bloc-Examples',
	#tag : 'EventHandling'
}

{ #category : 'instance creation' }
BlHandlerAnnouncerRegistryExamples >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ BlHandlerAnnouncerRegistry new
]
