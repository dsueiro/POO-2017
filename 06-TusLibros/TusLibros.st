!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'book1 cartWithOneBook1 emptyCatalog catalogWithOneBook emptyCartWithCatalogWithOneBook emptyCartWithEmptyCatalog priceListWithThreeItems cartWithMultipleOneBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 07:10:51'!
setUp
	emptyCatalog := Set new.
	emptyCartWithEmptyCatalog := Cart with: emptyCatalog.
	
	book1 := 'Un libro'. "Book withISIN: '1234' withTitle: 'book1' withAuthor: 'Jhon Doe'".

	catalogWithOneBook := Set new.
	catalogWithOneBook add: book1.

	emptyCartWithCatalogWithOneBook := Cart with: catalogWithOneBook.
	
	cartWithOneBook1 := Cart with: catalogWithOneBook.
	cartWithOneBook1 add: book1.
	
	priceListWithThreeItems := Dictionary new.
	priceListWithThreeItems add: (Association key: 'Un libro' value: 1.1).
	priceListWithThreeItems add: (Association key: 'Dos libro' value: 2.2).
	priceListWithThreeItems add: (Association key: 'Tres libro' value: 2.3).
	
	cartWithMultipleOneBooks := Cart with: catalogWithOneBook.
	cartWithMultipleOneBooks add: book1 withAmount: 5.

! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:31:34'!
test01ANewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:32:59'!
test02AfterAddingABookACartIsNotEmpty
	emptyCartWithCatalogWithOneBook add: book1.
	self deny: emptyCartWithCatalogWithOneBook isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:33:35'!
test03AfterAddingABookTheCartContainsOneBook1
	self assert: (cartWithOneBook1 includes: book1).
	self assert: (cartWithOneBook1 quantityOf: book1) equals: 1! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:33:57'!
test04BeforeAddingABookTheCartDoesNotContainsIt
	self deny: (emptyCartWithEmptyCatalog includes: book1).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:34:32'!
test05CannotAddABookWithQuantityLessThanOne
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 0]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add quantity less than one'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/14/2017 07:34:47'!
test06CannotAddABookWithANonIntegerQuantity
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 1.1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a non integer quantity'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 06:35:16'!
test07CannotAddABookThatIsNotFromTheCatalog
	self should: [emptyCartWithEmptyCatalog add: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog'.
		self assert: emptyCartWithEmptyCatalog isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 06:33:22'!
test08ACashierCannotDoCheckouWithAnEmptyCart
	|cashier| 
	
	cashier := Cashier with: priceListWithThreeItems.
	
	self should: [cashier checkout: emptyCartWithCatalogWithOneBook]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot do a checkout with an empty cart'.
		self todo: 'Add ventas object']
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 07:18:06'!
test09ACashierDoCheckouWithAnCartWithOneBook
	|cashier| 
	
	cashier := Cashier with: priceListWithThreeItems.
	
	self assert: 1.1 equals: (cashier checkout: cartWithOneBook1).
	self todo: 'Add ventas object'
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/21/2017 07:18:11'!
test10ACashierDoCheckoutWithACartWithMultipleBooks
	|cashier| 
	
	cashier := Cashier with: priceListWithThreeItems.
	
	self assert: 1.1 equals: (cashier checkout: cartWithMultipleOneBooks).
	self todo: 'Add ventas object'.
	! !


!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'masch 6/21/2017 06:31:01'!
todo: aString 
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
	instanceVariableNames: 'content catalog'
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

!Cart methodsFor: 'adding' stamp: 'masch 6/14/2017 07:10:45'!
add: aBook withAmount: aQuantity 
	self validateQuantity: aQuantity.
	self validateCatalog: aBook.
	content add: aBook withOccurrences: aQuantity.
	^aBook! !


!Cart methodsFor: 'evaluating' stamp: 'PEP 6/13/2017 00:04:43'!
includes: aBook
	^content includes: aBook! !

!Cart methodsFor: 'evaluating' stamp: 'masch 6/14/2017 07:09:56'!
quantityOf: aBook 
	^content occurrencesOf: aBook! !


!Cart methodsFor: 'initializing' stamp: 'masch 6/14/2017 07:02:27'!
catalog: aCatalog
	catalog := aCatalog.! !


!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:11:37'!
validateCatalog: aBook
	(catalog includes: aBook) ifFalse: [self error: 'Cannot add a book outside the catalog'].! !

!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:08:42'!
validateQuantity: aQuantity.
	aQuantity strictlyPositive ifFalse: [self error: 'Cannot add quantity less than one'].
	aQuantity isInteger ifFalse: [self error: 'Cannot add a non integer quantity'].! !


!Cart methodsFor: 'accessing' stamp: 'masch 6/21/2017 07:01:11'!
content
	^content! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'masch 6/21/2017 06:03:56'!
with: aCatalog
	^self new catalog: aCatalog; yourself ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/21/2017 07:02:05'!
checkout: aCart 
	|content totalPrice|
	(aCart isEmpty) ifTrue: [self error: 'Cannot do a checkout with an empty cart'].
	
	totalPrice := 0.
	content := aCart content.
	content do: [ :contentItem |
		totalPrice := totalPrice + priceList at: contentItem].
	
	^totalPrice.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/21/2017 06:24:57'!
priceList: aPriceList
	priceList := aPriceList ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'masch 6/21/2017 06:03:11'!
with: aPriceList
	^ self new priceList: aPriceList; yourself! !
