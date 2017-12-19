initialization
initialize
	super initialize.

	segments := OrderedCollection new.
	commands := IdentityDictionary new.
	"absolute commands"
	commands at: #A put: [ self A ].
	commands at: #C put: [ self C ].
	commands at: #H put: [ self H ].
	commands at: #L put: [ self L ].
	commands at: #M put: [ self M ].
	commands at: #Q put: [ self Q ].
	commands at: #S put: [ self S ].
	commands at: #T put: [ self T ].
	commands at: #V put: [ self V ].
	commands at: #Z put: [ self Z ].
	"relative commands"
	commands at: #a put: [ self a ].
	commands at: #c put: [ self c ].
	commands at: #h put: [ self h ].
	commands at: #l put: [ self l ].
	commands at: #m put: [ self m ].
	commands at: #q put: [ self q ].
	commands at: #s put: [ self s ].
	commands at: #t put: [ self t ].
	commands at: #v put: [ self v ].
	commands at: #z put: [ self z ]