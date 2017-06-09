

#zdefiniowanie obiektu typu BST posiadającego wartosc typu int, dwa liscie - lewy i prawy jako pusty typ tozsamy- BST
type BST
    wartosc::Int
    lewy::Nullable{BST}
    prawy::Nullable{BST}
#zdefiniowanie konstruktora dla jednego argumentu w wywolaniu , lewy i prawy zawsze jako Nullable typu BST
end

BST(key::Int) =BST(key, Nullable{BST}(), Nullable{BST}())   


function dodajDoDrzewa(korzen::BST, wartoscDodawna::Int)
	#dla wartosci mniejszych od wartosci korzenia
	if wartoscDodawna < korzen.wartosc
		if (isnull(korzen.lewy))
			korzen.lewy = BST(wartoscDodawna)
		else
			dodajDoDrzewa(korzen.lewy.value, wartoscDodawna)
		end
			
	elseif wartoscDodawna > korzen.wartosc
		if (isnull(korzen.prawy))
			korzen.prawy = BST(wartoscDodawna)
		else
			dodajDoDrzewa(korzen.prawy.value, wartoscDodawna)
		end
		
	#dla wartosci duplikatu wyswietlony komunikat.
	#zgodnie z opisem algorytmu w książce Algorytmy, Almanach na podstawie, której tworzony jest algorytmu
	#drzewo docelowo ma zwracać iformację, czy wartosc wystąpiła czy nie
	#nie ma sensu ponawiac istniejącej wartosci
	
	elseif wartoscDodawna == korzen.wartosc
		print("Wartosc już wystąpiła- nie dodano\n")
		return -1
	end
	
		
end

function sprawdzWyst(korzen::BST, wartoscSzukana::Int)
	#funkcja sprawdzjaca wystapienie elementu typu int w drzewie (Typ BST)
	try
	
	if wartoscSzukana == korzen.wartosc
		return true
	
	elseif wartoscSzukana < korzen.wartosc
		korzenNowy=get(korzen.lewy)
		sprawdzWyst(korzenNowy, wartoscSzukana)
	
	elseif wartoscSzukana > korzen.wartosc
		korzenNowy=get(korzen.prawy)
		sprawdzWyst(korzenNowy, wartoscSzukana)
	end
	catch
		return false
	end

end


function wyswietlMenu()
#funkcja wyswietlajaca menu - co moze użytkownik zrobic
	print("	MENU Przeszukiwania drzewa binarnego :\n\n")
	print("Podaj odpowiedni numer czynności, którą chciałbyś wykonać.\n")
	print("		1. Wyszukiwanie elementu wsrod podanych 5 liczb i klucza\n")
	print("		2. Wyszukiwanie elementu wsrod znacznej ilosci losowych liczb\n")
	print("		3. Wykonaj Testy aplikacji\n")
	print("		4. ZAKOŃCZ\n")
end


function zapytajCoZrobic()
#pobranie od uzytkownika wyboru , zwraca jako typ int
	wybor =(readline(STDIN))
	wybor =parse(Int,wybor)
	return wybor
end




function obslugaMenu()
	wyswietlMenu()
	k=zapytajCoZrobic()
	
	
	if k==1
	#wyszukiwanie elementu wsrod podanych liczb
		print("Podaj klucz główny: \n")
		kluczGlowny= zapytajCoZrobic()
		drzewo1=BST(kluczGlowny)
		print("Podaj pierwszą wartość do dodania: \n")
		wartosc1=zapytajCoZrobic()
		dodajDoDrzewa(drzewo1, wartosc1)
		print("Podaj drugą wartość do dodania: \n")
		wartosc2=zapytajCoZrobic()
		dodajDoDrzewa(drzewo1, wartosc2)
		print("Podaj pierwszą trzecią do dodania: \n")
		wartosc3=zapytajCoZrobic()
		dodajDoDrzewa(drzewo1, wartosc3)
		print("Podaj pierwszą czwartą do dodania: \n")
		wartosc4=zapytajCoZrobic()
		dodajDoDrzewa(drzewo1, wartosc4)
		print("Podaj pierwszą piątą do dodania: \n")
		wartosc5=zapytajCoZrobic()
		dodajDoDrzewa(drzewo1, wartosc5)
		print("Podaj jakiej wartosci szukamy w drzewie : \n")
		szukana1=zapytajCoZrobic()
		if (sprawdzWyst(drzewo1,szukana1)==true)
			print("Znaleziono szukaną wartosc, występuje w drzewie\n")
		else
			print("NIE znaleziono szukanej wartosci,nie występuje w drzewie\n")
		end
		obslugaMenu()
		
	elseif k==2
		print("Losujemy 100 liczb wśród wartości od -100 do 100 , klucz glowny to 0 \n")
		print("Następnie sprawdzamy czy wartosci 3, 5, 54, -39, -27, -34 wystąpiły \n")
	
		drzewo2=BST(0)
		tablicaLiczbLosowych=unique([rand(-100:100) for r in 1:100])
		for k in tablicaLiczbLosowych
			dodajDoDrzewa(drzewo2,k)
		end
		if (sprawdzWyst(drzewo2,3)==true)
			print("Znaleziono wartosc 3 w drzewie\n")
		end
		
		if (sprawdzWyst(drzewo2,5)==true)
			print("Znaleziono wartosc 5 w drzewie\n")
		end
		
		if (sprawdzWyst(drzewo2,54)==true)
			print("Znaleziono wartosc 54 w drzewie\n")
		end
		
		if (sprawdzWyst(drzewo2,-39)==true)
			print("Znaleziono wartosc -39 w drzewie\n")
		end		
		
		if (sprawdzWyst(drzewo2,-27)==true)
			print("Znaleziono wartosc -27 w drzewie\n")
		end
		
		if (sprawdzWyst(drzewo2,-34)==true)
			print("Znaleziono wartosc -34 w drzewie\n")
		end
		print("Wylosowane drzewo to : ")
		print(tablicaLiczbLosowych)
		obslugaMenu()
	
	elseif k==3
	print("Wykonuje plik test.jl :\n ")
		include("test.jl")
		obslugaMenu()
	elseif k==4
		quit()
	else
	print("Zła wartość")
	obslugaMenu()
	end
	
	


end

obslugaMenu()





