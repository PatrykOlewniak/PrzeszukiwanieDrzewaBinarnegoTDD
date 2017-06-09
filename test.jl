using FactCheck


#aby rozmawiac o drzewie bst musimy pierw zdefiniowac wartosc jego korzenia
#w algorytmie drzewa BST kazdy element jest rowniez drzewem - takim samym typem 
#Elementy powinny byc typu BST posiadajacego trzy wartosci
#wartosc, lewy lisc oraz prawy lisc. 


#TEST1- wartosci typu BST



#sprawdzimy czy mozliwe jest przypisanie wartosci do obiektu typu bst i jakie to moga byc obiekty
 
facts("Testowanie wartosci obiektu BST") do
	BST1 = BST(0)
	@fact BST1.wartosc --> 0
	BST2=BST(-30)
	#sprawdzenie dla ujemnych
	BST2 = BST(-30)
	BST3A = BST(-58495)
	@fact BST2.wartosc --> -30
	@fact BST3A.wartosc --> -58495
	#sprawdzenie czy przy zmiennoprzecinkowych "wyrzucany" jest MethodError
	@fact_throws MethodError BST4 = BST(-3.4)
	@fact_throws MethodError BST5 = BST(3.489898)
	#test czy poza zakresem typu int rowniez jest MethodError
	@fact_throws MethodError BST6 = BST(3934023940239090909094)
    @fact_throws MethodError BST7 = BST(-8384023940239090909994)
	
	#dla "innych"
	@fact_throws MethodError BST3 = BST("aa") 
	@fact_throws MethodError BST3 = BST('a')
	@fact_throws MethodError BST3 = BST('0')
	@fact_throws UndefVarError BST4 = BST(323s32)
	
end

#TEST2 - test lewego i prawego liscia obiektu typu bst - korzenia)
facts("Testowanie lewego i prawego liscia obiektu typu bst") do
	BSTK = BST(0)
	@fact typeof(BSTK.lewy) -->Nullable{BST}
	@fact typeof(BSTK.prawy) -->Nullable{BST}
	@fact isnull(BSTK.lewy)-->true
	@fact isnull(BSTK.prawy)-->true
	BSTK.lewy = BST(-30)
	@fact isnull(BSTK.lewy)-->false
	#pobranie wartosci - typ nullable wiec poprzed wbudowana metode get
	@fact get(BSTK.lewy).wartosc --> -30
	BSTK.prawy = BST(60)
	@fact get(BSTK.prawy).wartosc --> 60
end


#TEST3 - testy funcji dodającej elementy do wcześniej zdefiniowanego korzenia przy urzyciu odpowiedniej funkcji
facts("Testy funcji dodającej elementy do drzewa") do
	#ustanawionyt testowo korzen1 jako wartosc 0 
	korzen1=BST(0)
	dodajDoDrzewa(korzen1,20)
	#dodano do drzewa wartosc 20 zatem wg algorytmu powinna znalezc się w prawym lisciu od korzenia
	@fact get(korzen1.prawy).wartosc--> 20
	
	#sprawdzenie powtorki wartosci 
	dodajDoDrzewa(korzen1,-30)
	@fact get(korzen1.lewy).wartosc--> -30
	
	#przypadki gdzie juz są takie elementy 
	@fact dodajDoDrzewa(korzen1,0)-->-1
	@fact dodajDoDrzewa(korzen1,-30)-->-1
	korzen2=BST(60)
	dodajDoDrzewa(korzen2, 50)
	dodajDoDrzewa(korzen2, 65)
	
	#sprawdzenie czy mniejsza idzie do lewego a wieksza do prawego liscia
	@fact get(korzen2.lewy).wartosc-->50
	@fact get(korzen2.prawy).wartosc-->65
end


#TEST4 - testy zwiazane ze zwracaniem odpowiednich wartosci przez metode sprawdzajaca
facts("Testy funkcji zwracajacej true przy wystepowaniu danego elementu w drzewie, false w wypadku przeciwnym") do

	#sprawdzenie czy dla samego korzenia funkcja dziala prawidlowo
	TestBST=BST(0)
	@fact sprawdzWyst(TestBST, 0)-->true
	@fact sprawdzWyst(TestBST, 20)-->false
	@fact sprawdzWyst(TestBST, -1)-->false
	
	#do testowego drzewa dodajemy kilka wartosci by przetestowac drzewo majace wiecej korzeni,lisci
	dodajDoDrzewa(TestBST,2)
	dodajDoDrzewa(TestBST,-2)
	dodajDoDrzewa(TestBST,302)
	dodajDoDrzewa(TestBST,89)
	
	#sprawdzamy czy rozne liczby wystąpiły w drzewie i czy funkcja zwroci odp. wartosc
	@fact sprawdzWyst(TestBST, 439)-->false
	@fact sprawdzWyst(TestBST, 0)-->true
	
	#dodamy jeszcze wiecej elementow
	dodajDoDrzewa(TestBST,-2)
	#
	dodajDoDrzewa(TestBST,-39)
	dodajDoDrzewa(TestBST,-489)
	dodajDoDrzewa(TestBST,-3498324)
	dodajDoDrzewa(TestBST, 2332)
	dodajDoDrzewa(TestBST, 4324)
	@fact sprawdzWyst(TestBST, -489)-->true
	@fact sprawdzWyst(TestBST,-39)-->true
	@fact sprawdzWyst(TestBST,49023490)-->false
end


