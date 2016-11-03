effect
applyEffectOn: anAthensCanvas for: anAtom around: aBlock
	self flag: #forGlenn.
	"strange that only around is used"
	aBlock value