*Bloc
asBlKeyCombination
	| blkc mods |
	mods := self modifier modifiers.
	blkc := BlKeyCodeCombination new char: self character key.
	blkc modifiers
		ctrl: (mods includes: KMModifier ctrl);
		shift: (mods includes: KMModifier shift);
		alt: (mods includes: KMModifier alt);
		cmd: (mods includes: KMModifier command).
	^ blkc