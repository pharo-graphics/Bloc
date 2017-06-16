instance creation
paint: aPaint width: aNumber

	^ self builder
		paint: aPaint;
		width: aNumber;
		build