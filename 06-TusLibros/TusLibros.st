!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'book1 cartWithOneBook1 emptyCatalog catalogWithOneBook emptyCartWithCatalogWithOneBook emptyCartWithEmptyCatalog priceListWithThreeItems cartWithFiveOneBooks book2 catalogWithMultipleBooks cartWithMultipleBooks creditCardExpiredOn052012 salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 18:58:49'!
setUp
	salesBook _ SalesBook new.
	
	emptyCatalog := Set new.
	emptyCartWithEmptyCatalog := Cart with: emptyCatalog.
	
	book1 := 'Un libro'. "Book withISIN: '1234' withTitle: 'book1' withAuthor: 'Jhon Doe'".
	book2 := 'Dos libro'. "Book withISIN: '1234' withTitle: 'book1' withAuthor: 'Jhon Doe'".

	catalogWithOneBook := Set new.
	catalogWithOneBook add: book1.

	catalogWithMultipleBooks := Set new.
	catalogWithMultipleBooks add: book1.
	catalogWithMultipleBooks add: book2.

	emptyCartWithCatalogWithOneBook := Cart with: catalogWithOneBook.
	
	cartWithOneBook1 := Cart with: catalogWithOneBook.
	cartWithOneBook1 add: book1.
	
	priceListWithThreeItems := Dictionary new.
	priceListWithThreeItems add: (Association key: 'Un libro' value: 1).
	priceListWithThreeItems add: (Association key: 'Dos libro' value: 2).
	priceListWithThreeItems add: (Association key: 'Tres libro' value: 3).
	
	cartWithFiveOneBooks := Cart with: catalogWithOneBook.
	cartWithFiveOneBooks add: book1 withAmount: 5.
	
	cartWithMultipleBooks := Cart with: catalogWithMultipleBooks.
	cartWithMultipleBooks add: book1 withAmount: 3.
	cartWithMultipleBooks add: book2 withAmount: 4.

	creditCardExpiredOn052012 := CreditCard withName: 'Juan Perez' withNumber: 1000000000000000 withExpirationDate: (Date newDay: 01 month: 05 year: 2012).

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

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 18:59:04'!
test08CannotCreateACashierWithAnEmptyCart	
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: emptyCartWithCatalogWithOneBook 
		                             withCreditCard: creditCardExpiredOn052012 
		                             withPaymentDay: (Date newDay: 1  month: 4 year: 2012)
		                             withSalesBook: salesBook]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot create a cashier with an empty cart']
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:08:29'!
test09ACashierDoCheckouWithAnCartWithFiveOneBook
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: creditCardExpiredOn052012 
	                              withPaymentDay: (Date newDay: 1  month: 4 year: 2012)
	                              withSalesBook: salesBook.
	
	self assert: 5 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:10:29'!
test10ACashierDoCheckoutWithACartWithMultipleBooks
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithMultipleBooks 
	                              withCreditCard:  creditCardExpiredOn052012 
	                              withPaymentDay: (Date newDay: 1  month: 4 year: 2012)
	                              withSalesBook: salesBook.
	
	self assert: 11 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:22'!
test11CannotCreateACreditCardWithAnEmptyName
	self should: [CreditCard withName: '' 
		                                   withNumber: 12345 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Name cannot be empty'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:42'!
test12CannotCreateACreditCardWithAPositiveNumberLessThanSixteenLength
	self should: [CreditCard withName: 'Juan Perez' 
		                                   withNumber: 999999999999999 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Number must have at least 16 numbers'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:14:06'!
test13ACreditCardWithAnExpirationDateLessThanADayIsExpired
	|creditCard|
	
	creditCard := CreditCard withName: 'Juan Perez' 
	                                         withNumber: 1000000000000000 
	                                         withExpirationDate: (Date newDay: 01 month: 05 year: 2012).
	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 5 year: 2012)).	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 8 year: 2012)).
	self assert: (creditCard isExpiredOn: (Date newDay: 1 month: 1 year: 2017)).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:12:04'!
test14CannotCreateACashierWithACreditcardExpired
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: cartWithFiveOneBooks 
		                             withCreditCard: creditCardExpiredOn052012 
		                             withPaymentDay: (Date newDay: 1  month: 12 year: 2012) 
		                             withSalesBook: salesBook]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'The expiration date card is expired'.]
	
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

!Cart methodsFor: 'accessing' stamp: 'masch 6/24/2017 09:06:50'!
totalPrice: aPricesList 
	|totalPrice|
		
	totalPrice := 0.
	content asSet do: [ :contentItem |
		totalPrice := totalPrice + ((aPricesList at: contentItem) * (content occurrencesOf: contentItem))].
	
	^totalPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'masch 6/21/2017 06:03:56'!
with: aCatalog
	^self new catalog: aCatalog; yourself ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:18:28'!
cart: aCart 
	cart := aCart ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:03:31'!
checkout
	|salePrice|
	salePrice := cart totalPrice: priceList.
	salesBook addSale: salePrice.
	^salePrice
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/21/2017 06:24:57'!
priceList: aPriceList
	priceList := aPriceList ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:08:58'!
salesBook
	^salesBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:05:25'!
salesBook: aSalesBook
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'masch 6/24/2017 18:57:10'!
withPriceList: aPriceList withCart: aCart withCreditCard: aCreditCard withPaymentDay: aPaymentDay withSalesBook: aSalesBook

	self validateCart: aCart.
	self validateCardOn: aCreditCard withPaymentDay: aPaymentDay.

	^ self new priceList: aPriceList; cart: aCart; salesBook: aSalesBook; yourself! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:15:38'!
validateCardOn: aCreditCard withPaymentDay: aPaymentDay 
	(aCreditCard isExpiredOn: aPaymentDay) ifTrue: [self error: 'The expiration date card is expired'].! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:25:48'!
validateCart: aCart 
	(aCart isEmpty) ifTrue: [self error: 'Cannot create a cashier with an empty cart'].! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:36:47'!
expirationDate: anExpirationDate 
	expirationDate := anExpirationDate! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 17:51:27'!
isExpiredOn: aDateFrom 
	^expirationDate < aDateFrom! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:28:40'!
name: aName 
	name := aName ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 15:32:29'!
number: aNumber 
	number := aNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:20:16'!
validateName: aName
	(aName isEmpty) ifTrue: [ self error: 'Name cannot be empty'].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:29:24'!
validateNumber: aNumber 
	(aNumber < 1000000000000000) ifTrue: [self error: 'Number must have at least 16 numbers'].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 16:25:13'!
withName: aName withNumber: aNumber withExpirationDate: aExpirationDate
	self validateName: aName.
	self validateNumber: aNumber.
	
	^self new name: aName; number: aNumber; expirationDate: aExpirationDate; yourself! !


!classDefinition: #SalesBook category: #TusLibros!
Object subclass: #SalesBook
	instanceVariableNames: 'salesCollectionBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 19:00:15'!
addSale: aSalePrice
	^salesCollectionBook add: aSalePrice! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:54:16'!
initialize
	salesCollectionBook _ OrderedCollection new.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'masch 6/24/2017 18:51:25'!
isEmpty
	^salesCollectionBook isEmpty.! !
