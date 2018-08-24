"
I contain examples of event handler registry with Announcer as its backend
"
Class {
	#name : #BlHandlerAnnouncerRegistryExamples,
	#superclass : #Object,
	#traits : 'TBlHandlerRegistryExamples',
	#classTraits : 'TBlHandlerRegistryExamples classTrait',
	#category : 'Bloc-Examples-EventHandling'
}

{ #category : #'instance creation' }
BlHandlerAnnouncerRegistryExamples >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ BlHandlerAnnouncerRegistry new
]
