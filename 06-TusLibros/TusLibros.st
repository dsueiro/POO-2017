!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'emptyCart book1 cartWithOneBook1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'DHS 6/13/2017 20:54:13'!
setUp
	
	emptyCart := Cart new.
	book1 := 'Un libro'. "Book withISIN: '1234' withTitle: 'book1' withAuthor: 'Jhon Doe'".
	cartWithOneBook1 := Cart new add: book1.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/12/2017 22:58:03'!
test01ANewCartIsEmpty
	self assert: emptyCart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/12/2017 23:14:02'!
test02AfterAddingABookACartIsNotEmpty
	emptyCart add: book1.
	self deny: emptyCart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/12/2017 23:37:06'!
test03AfterAddingABookTheCartContainsOneBook1
	self assert: (cartWithOneBook1 includes: book1).
	self assert: (cartWithOneBook1 quantityOf: book1) equals: 1! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/12/2017 23:18:25'!
test04BeforeAddingABookTheCartDoesNotContainsIt
	self deny: (emptyCart includes: book1).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/13/2017 00:16:14'!
test05CannotAddABookWithQuantityLessThanOne
	self should: [emptyCart add: book1 withAmount: 0]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add quantity less than one']
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DHS 6/13/2017 19:43:41'!
test06CannotAddABookWithANonIntegerQuantity
	self should: [emptyCart add: book1 withAmount: 1.1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a non integer quantity']
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'DHS 6/13/2017 21:05:10'!
test07CannotAddABookThatIsNotFromTheCatalog
	|catalog cart| 
	catalog := Set new. 
	cart := Cart with: catalog.
	self should: [cart add: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog']
	
	! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: 'title author isin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialize' stamp: 'PEP 6/12/2017 23:49:49'!
initialize
	title := ''.
	author := ''.
	isin := ''! !


!Book methodsFor: 'accessing' stamp: 'PEP 6/12/2017 23:55:32'!
author: aBookAuthor 
	author := aBookAuthor! !

!Book methodsFor: 'accessing' stamp: 'PEP 6/12/2017 23:54:24'!
isin: anISIN 
	isin := anISIN! !

!Book methodsFor: 'accessing' stamp: 'PEP 6/12/2017 23:54:59'!
title: aBookTitile 
	title := aBookTitile! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #TusLibros!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'initialization' stamp: 'PEP 6/12/2017 23:53:54'!
withISIN: anISIN withTitle: aBookTitle withAuthor: aBookAuthor
	^self new isin: anISIN; title: aBookTitle; author: aBookAuthor; yourself! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'inspecting' stamp: 'PEP 6/13/2017 00:02:35'!
initialize
	content := Bag new! !

!Cart methodsFor: 'inspecting' stamp: 'PEP 6/12/2017 22:15:34'!
isEmpty
	^content isEmpty! !


!Cart methodsFor: 'adding' stamp: 'DHS 6/13/2017 21:00:47'!
add: aCartItem
	self add: aCartItem withAmount: 1! !

!Cart methodsFor: 'adding' stamp: 'DHS 6/13/2017 19:52:48'!
add: aBook withAmount: aQuantity 
	self validateQuantity: aQuantity.
	content add: aBook withOccurrences: aQuantity.
	^aBook! !

!Cart methodsFor: 'adding' stamp: 'DHS 6/13/2017 19:53:19'!
validateQuantity: aQuantity.
	aQuantity strictlyPositive ifFalse: [self error: 'Cannot add quantity less than one'].
	aQuantity isInteger ifFalse: [self error: 'Cannot add a non integer quantity'].! !


!Cart methodsFor: 'evaluating' stamp: 'PEP 6/13/2017 00:04:43'!
includes: aBook
	^content includes: aBook! !


!Cart methodsFor: 'as yet unclassified' stamp: 'PEP 6/13/2017 00:03:58'!
quantityOf: aBook 
	^content occurrencesOf: aBook
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'DHS 6/13/2017 21:08:06'!
with: aCatalog
	^self new.! !
