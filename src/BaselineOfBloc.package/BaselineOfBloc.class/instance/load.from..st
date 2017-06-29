private
load: aBaselineName from: aRepository
	"I choose appropriate loading method for a baseline from repository
	depending on requested directive"
	| aDirective |

	"we load code only using metacello, not actions needed"
	self hasDirective
		ifFalse: [ ^ self ].
	
	aDirective := self directive.
	
	"we do nothing for minimal directive"
	aDirective = #minimal
		ifTrue: [ ^ self ].

	Warning signal: 'Unknown load directive ' , aDirective asString