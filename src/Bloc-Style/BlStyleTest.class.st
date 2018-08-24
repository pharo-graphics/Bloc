Class {
	#name : #BlStyleTest,
	#superclass : #TestCase,
	#category : 'Bloc-Style-Tests'
}

{ #category : #'as yet unclassified' }
BlStyleTest >> testPrecedence [
	|ss el|
	el := BlElement new styleClass: #test.
	ss := BlStylesheet new
		for:'.test' style:[:s| s declare:#color-> Color green];
		for:'.test' style:[:s| s declare:#color-> Color green];
		for:'.test' style:[:s| s declare:#color-> Color yellow];
		for:'.test' style:[:s| s declare:#color-> Color yellow].
	el addStylesheet: ss.
	el styler compute.
	self assert: el styler styles size = 2 description: 'same styles should be excluded'.
	self assert: (el styler matchingStyleMap at:#color) value  = Color yellow description:'the last declared style should be applied'

]

{ #category : #'as yet unclassified' }
BlStyleTest >> testPrecedenceWithImportant [
	|ss el|
	el := BlElement new styleClass: #test.
	ss := BlStylesheet new
		for:'.test' style:[:s| s declare:#color-> Color green];
		for:'.test' style:[:s| s declare:#color-> Color green important:true];
		for:'.test' style:[:s| s declare:#color-> Color yellow];
		for:'.test' style:[:s| s declare:#color-> Color yellow].
	el addStylesheet: ss.
	el styler compute.
	self assert: el styler styles size = 3 description: 'same styles should be excluded'.
	self assert: (el styler matchingStyleMap at:#color) value  = Color green description:'the important style should be applied'

]
