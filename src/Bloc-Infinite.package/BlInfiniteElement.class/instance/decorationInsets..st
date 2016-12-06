children - geometry
decorationInsets: anElement
	"Return decoration insets for the given element"
	<return: #Rectangle>
	| anInfiniteConstraints |

	anInfiniteConstraints := anElement constraints infinite.
	anInfiniteConstraints insetsDirty
		ifTrue: [ ^ anInfiniteConstraints decorationInsets ].
	
	(self state isPreLayout and: [
		anInfiniteConstraints isItemChanged or: [
			anInfiniteConstraints isElementInvalid ] ])
				"changed/invalid items should not be updated until they are rebound"
				ifTrue: [ ^ anInfiniteConstraints decorationInsets ].
	
	self flag: 'Implement decorations'.
		"	

        final Rect insets = lp.mDecorInsets;
        insets.set(0, 0, 0, 0);
        final int decorCount = mItemDecorations.size();
        for (int i = 0; i < decorCount; i++) {
            mTempRect.set(0, 0, 0, 0);
            mItemDecorations.get(i).getItemOffsets(mTempRect, child, this, mState);
            insets.left += mTempRect.left;
            insets.top += mTempRect.top;
            insets.right += mTempRect.right;
            insets.bottom += mTempRect.bottom;
        }
        lp.mInsetsDirty = false;
        return insets;"