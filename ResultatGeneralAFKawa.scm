;; Kawa Scheme code for java virtual machine and tomcat web server

;; author: Damien Mattei

;; compilation method:

;;  java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl -C ResultatGeneralAFKawa.scm
;; jar cf ~/Dropbox/KawaFunctProg.jar eu

;; old and other method,depending jdk version:
;; (java -jar ~/Dropbox/kawa-2.1-jdk8.jar -C ResultatGeneralAFKawa.scm)
;; (java -jar /usr/local/share/java/kawa-2.1.jar -C ResultatGeneralAFKawa.scm)
;; (other method to compile: kawa -C ResultatGeneralAFKawa.scm )
;; (jar cf KawaFunctProg.jar eu)

(module-name "eu.oca.kawafunct.ResultatGeneralAFKawa")

(require 'regex)

;;(include-relative  "../lib/syntactic-sugar.scm") ;; YES in kawa you can include files from other schemes...
;;(include-relative  "../lib/display.scm")

(include-relative  "../git/LOGIKI/lib/syntactic-sugar.scm") ;; YES in kawa you can include files from other schemes...
(include-relative  "../git/LOGIKI/lib/display.scm")
(include-relative  "../git/LOGIKI/lib/debug.scm") ;; for debug
(include-relative  "../git/LOGIKI/lib/case.scm") ;; for CASE with STRINGS


(define-simple-class ResultatGeneralAFKawa ()

  (CocherNom ::java.lang.String init-keyword: CocherNom:)
  (Nom ::java.lang.String init-keyword: Nom:)
  (CocherHIP ::java.lang.String init-keyword: CocherHIP:)
  (CocherOrb ::java.lang.String init-keyword: CocherOrb:)
  (CocherAlpha ::java.lang.String init-keyword: CocherAlpha:)
  (AlphaMin ::java.lang.String init-keyword: AlphaMin:)
  (AlphaMax ::java.lang.String init-keyword: AlphaMax:)
  (CocherDelta ::java.lang.String init-keyword: CocherDelta:)
  (DeltaMin ::java.lang.String init-keyword: DeltaMin:)
  (DeltaMax ::java.lang.String init-keyword: DeltaMax:)
  (CocherMag1 ::java.lang.String init-keyword: CocherMag1:)
  (Mag1Min ::java.lang.String init-keyword: Mag1Min:)
  (Mag1Max ::java.lang.String init-keyword: Mag1Max:)
  (CocherMag2 ::java.lang.String init-keyword: CocherMag2:)
  (Mag2Min ::java.lang.String init-keyword: Mag2Min:)
  (Mag2Max ::java.lang.String init-keyword: Mag2Max:)
  (CocherDiffMag ::java.lang.String init-keyword: CocherDiffMag:)
  (Mag2Mag1 ::java.lang.String init-keyword: Mag2Mag1:)
  (CocherAnnee ::java.lang.String init-keyword: CocherAnnee:)
  (annee ::java.lang.String init-keyword: annee:)
  (CocherSepar ::java.lang.String init-keyword: CocherSepar:)
  (SeparMin ::java.lang.String init-keyword: SeparMin:)
  (CocherType ::java.lang.String init-keyword: CocherType:)
  (type1 ::java.lang.String init-keyword: type1:)
  (type2 ::java.lang.String init-keyword: type2:)
  (CocherNbMes ::java.lang.String init-keyword: CocherNbMes:)
  (NbMes ::java.lang.String init-keyword: NbMes:)

  ;;(rs ::java.sql.ResultSet init-keyword: rs:)
  (res ::java.lang.String init-keyword: res:)

 

  ;; ;; Alternative type-specification syntax.
  ;; (y type: double init-keyword: y:)
  ;; (zero-2d :: ResultatGeneralAFKawa allocation: 'static
  ;;  init-value: (ResultatGeneralAFKawa 0))
  ;; ;; An object initializer (constructor) method.
  ;; ((*init* (x0 ::double) (y0 ::double))
  ;;  (set! x x0)
  ;;  (set! y y0))
  ((*init* (nomParam ::java.lang.String)) ;; juste pour garder la surcharge
   (set! Nom nomParam))

  ((*init* (cochernomParam ::java.lang.String)
	   (nomParam ::java.lang.String)
	   (cocherhipParam ::java.lang.String)
	   (cocherorbParam ::java.lang.String)
	   (cocheralphaParam ::java.lang.String)
	   (alphaminParam ::java.lang.String)
	   (alphamaxParam ::java.lang.String)
	   (cocherdeltaParam ::java.lang.String)
	   (deltaminParam ::java.lang.String)
	   (deltamaxParam ::java.lang.String)
	   (cochermag1Param ::java.lang.String)
	   (mag1minParam ::java.lang.String)
	   (mag1maxParam ::java.lang.String)
	   (cochermag2Param ::java.lang.String)
	   (mag2minParam ::java.lang.String)
	   (mag2maxParam ::java.lang.String)
	   (cocherdiffmagParam ::java.lang.String)
	   (mag2mag1Param ::java.lang.String)
	   (cocheranneeParam ::java.lang.String)
	   (anneeParam ::java.lang.String)
	   (cocherseparParam ::java.lang.String)
	   (separminParam ::java.lang.String)
	   (cochertypeParam ::java.lang.String)
	   (type1Param ::java.lang.String)
	   (type2Param ::java.lang.String)
	   (cochernbmesParam ::java.lang.String)
	   (nbmesParam ::java.lang.String)

	   )
   
   (set! CocherNom cochernomParam)
   (set! Nom nomParam)
   (set! CocherHIP cocherhipParam)
   (set! CocherOrb cocherorbParam)
   (set! CocherAlpha cocheralphaParam)
   (set! AlphaMin alphaminParam)
   (set! AlphaMax alphamaxParam)
   (set! CocherDelta cocherdeltaParam)
   (set! DeltaMin deltaminParam)
   (set! DeltaMax deltamaxParam)
   (set! CocherMag1 cochermag1Param)
   (set! Mag1Min mag1minParam)
   (set! Mag1Max mag1maxParam)
   (set! CocherMag2 cochermag2Param)
   (set! Mag2Min mag2minParam)
   (set! Mag2Max mag2maxParam)
   (set! CocherDiffMag cocherdiffmagParam)
   (set! Mag2Mag1 mag2mag1Param)
   (set! CocherAnnee cocheranneeParam)
   (set! annee anneeParam)
   (set! CocherSepar cocherseparParam)
   (set! SeparMin separminParam)
   (set! CocherType cochertypeParam)
   (set! type1 type1Param)
   (set! type2 type2Param)
   (set! CocherNbMes cochernbmesParam)
   (set! NbMes nbmesParam)

   

   #;(work))

  ;; ((*init* (xy0 ::double))
  ;;  ;; Call above 2-argument constructor.
  ;;  (invoke-special ResultatGeneralAFKawa (this) '*init* xy0 xy0))

  ;; Need a default constructor as well.
  ((*init*) #!void)

  ;; ((add (other ::ResultatGeneralAFKawa)) ::ResultatGeneralAFKawa
  ;;  ;; Kawa compiles this using primitive Java types!
  ;;  (ResultatGeneralAFKawa
  ;;    x: (+ x other:x)
  ;;    y: (+ y other:y)))
  ;; ((scale (factor ::double)) ::ResultatGeneralAFKawa
  ;;  (ResultatGeneralAFKawa x: (* factor x) y: (* factor y)))
  
 

 

  ((work) ::java.lang.String ;; do the job:
   (eu.oca.DataBase:searchDriverStatic)
   (display "ResultatGeneralAFKawa : work : eu.oca.DataBase:searchDriverStatic PASSED")
   (newline)
   ;;(eu.oca.DataBase:helloStatic)
   (eu.oca.DataBase:connectStatic)
   (display "ResultatGeneralAFKawa : work : eu.oca.DataBase:connectStatic PASSED")
   (newline)

   (eu.oca.DataBase:createStatementStatic) ;; i put the statement here if it's true it can be reused for multiple SQL queries
   (display "ResultatGeneralAFKawa : work : eu.oca.DataBase:createStatementStatic PASSED")
   (newline)

   ;; (set! rs eu.oca.DataBase:resultSet)
   ;; (display "ResultatGeneralAFKawa : work : eu.oca.DataBase:resultSet PASSED")
   ;; (newline)

   (let* ((marequete
	   ;;(sql-server->mysql-server-syntax 
	    (string-append 
	    "SELECT DISTINCT Coordonnées.Nom, Coordonnées.[Alpha 2000], Coordonnées.[Delta 2000]"
	    ", Coordonnées.[N° BD], Coordonnées.[N° ADS], Coordonnées.[N° HIP], Coordonnées.mag1, Coordonnées.mag2"
	    ", Coordonnées.Spectre"
	    " FROM Coordonnées INNER JOIN Mesures ON Coordonnées.[N° Fiche] = Mesures.[N° Fiche] ")
	    ;;)
	  )
	  (monordre (sql-server->mysql-server-syntax " ORDER by Coordonnées.[Alpha 2000]"))
	  (cocher 0)
	  (flagerreur 0)
	  (erreurgeneral 0)
	  (baraterreur "Please reload the page and resume : ")
	  (Et " AND ")
	  (dont "WHERE ")
	  (Group (sql-server->mysql-server-syntax
		  (string-append
		   "GROUP BY Coordonnées.Nom, Coordonnées.[Alpha 2000], Coordonnées.[Delta 2000]"
		   ", Coordonnées.[N° BD], Coordonnées.[N° ADS], Coordonnées.[N° HIP], Coordonnées.mag1, Coordonnées.mag2"
		   ", Coordonnées.Spectre, Coordonnées.Orb, Coordonnées.[N°Type] HAVING ")))
	  (baratin " List of objects ")
	  (Clause dont)
	  (caseannee CocherAnnee)
	  (casenbmes CocherNbMes)
	  (casesepar CocherSepar)
	  (casenom CocherNom)
	  (caseHIP CocherHIP)
	  (caseorb CocherOrb)
	  (casealfa CocherAlpha)
	  (casedelta CocherDelta)
	  (casemag1 CocherMag1)
	  (casemag2 CocherMag2)
	  (casediffmag CocherDiffMag)
	  (casetype CocherType)
	  (separmin '())
	  (objet '())
	  (data "")
	  (alfamin '())
	  (alfamax '())
	  (deltamin '())
	  (deltamax '())
	  (sign '())
	  (resultd '())
	  (resultmi '())
	  (deminresult '())
	  (demaxresult '())
	  (iminresult '())
	  (imaxresult '())
	  (resultm '()) ;; minutes
	  (resulth '()) ;; hours
	  (results '()) ;; seconds
	  (mag1min '())
	  (mag1max '())
	  (mag2min '())
	  (mag2max '())
	  (diffmag '())
	  (nutype1 0)
	  (nutype2 0)
	  (rs ::java.sql.ResultSet #!null)
	  (total '())
	  (result '())
	  (iresult '())
	  (aresult '())
	  )
     
     (set! debug-mode #f)

     (set! res 
	   (gnu.lists.FString:toString
	    (string-append 
	      "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">"
	      "<html>"
	      "<head>"
	      #;"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">"
	      "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
	      "<meta name=\"GENERATOR\" content=\"Java Kawa Scheme\">"
	      "<title>SIDONIe-Résultats statistiques</title>"
	      "</head>"
	      "<LINK rel=\"stylesheet\" href=\"../Style.css\" type=\"text/css\">"
	      "<body  <!--bgcolor=\"#FFFFA6\" text=\"#004040\" link=\"#0000FF\" vlink=\"#808000\" alink=\"#800000\"-->")))
     
     (display-msg-var-nl  "ResultatGeneralAFKawa : work : marequete = " marequete)
  
     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : caseannee = " caseannee)

     (if-t (and (string? caseannee) (string=? caseannee "ON"))
	   (debug-only display-nl  "ResultatGeneralAFKawa : work : dans if-t ... caseannee")
	   (set! erreurgeneral 1)
	   (set! data annee)
	   (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : annee = " annee)
	   (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : data = " data)
	   (if (string=? data "")
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give the year!")))
	       ;; else
	       (if (or (<= (string->number data) 1750) (>= (string->number data) 2050))
		   (begin
		     (set! flagerreur 1)
		     (set! baraterreur (string-append baraterreur " You gave a wrong year !")))
		   ;; else
		   (if (= cocher 0)
		       (begin
			 (set! cocher 1)
			 (set! baratin (string-append baratin " unobserved from " data))
			 ;;(set! marequete (string-append marequete Group "Max(Cdbl(Mesures.Date)) <= " "Cdbl(" data ")")))
			 (set! marequete (string-append marequete Group "Max(Mesures.Date) <= " data )))
		       ;; else
		       (set! res (gnu.lists.FString:toString (string-append res "Please reload the page and resume : wrong choice !!"))))))) ;; enf if-t



     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casenbmes = " casenbmes)

     (if-t (and (string? casenbmes) (string=? casenbmes "ON"))
	   (set! erreurgeneral 1)
	   (set! data NbMes)
	   (if (string=? data "")
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give the maximum number of measurements !")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     (set! baratin (string-append baratin " with the number of measurements <= " data))
		     ;;(set! marequete (string-append marequete Group "Count(Mesures.Date) <= " "Cdbl(" data ")")))
		     (set! marequete (string-append marequete Group "Count(Mesures.Date) <= " data )))
		   ;; else
		   (begin
		     (set! baratin (string-append baratin ", with the number of measurements <= " data))
		     ;;(set! marequete (string-append marequete Et "Count(Mesures.Date) <= " "Cdbl(" data ")")))))) ;; enf if-t
		     (set! marequete (string-append marequete Et "Count(Mesures.Date) <= " data)))))) ;; enf if-t
     
     
     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casesepar = " casesepar)

     (if-t (and (string? casesepar) (string=? casesepar "ON"))
	   (set! erreurgeneral 1)
	   (set! separmin SeparMin)
	   (if (string=? separmin "")
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you didn't give a min separation ! ")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     ;; (set! baratin (string-append baratin  " (Requète séparation non encore opérationnelle !) "))
		     (set! baratin (string-append baratin "  with at least one separation <= " separmin  " arcseconds"))
		     (set! marequete (string-append marequete Group))
		     ;;(set! marequete (string-append marequete "Min(Cdbl(Mesures.Sépar)) <= " "Cdbl(" separmin ")"
		     (set! marequete (string-append marequete "Min(Mesures.Sépar) <= " separmin)))
		   ;; else
		   (begin
		     ;;(set! baratin (string-append baratin  " (Requète séparation non encore opérationnelle !) "))
		     (set! baratin (string-append baratin ", with at least one separation <= " separmin " arcseconds"))))))



     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casenom = " casenom)

     (if-t (and (string? casenom) (string=? casenom "ON"))
	   (set! erreurgeneral 1)
	   (set! objet Nom)
	   (if (string=? objet "")
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give a name ! ")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     (set! baratin (string-append baratin " with name beginning by " objet))
		     (set! marequete (string-append marequete dont "Coordonnées.Nom like '" objet " _%" "'")))
		   ;; else
		   (begin
		     (set! baratin (string-append baratin ",  with name beginning by " objet))
		     (set! marequete (string-append marequete  Et "Coordonnées.Nom like '" objet " _%" "'"))))))

		   
     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : caseHIP = " caseHIP)

     (if-t (and (string? caseHIP) (string=? caseHIP "ON"))
	   (set! erreurgeneral 1)
	   (if (= cocher 0)
	       (begin
		 (set! cocher 1)
		 (set! baratin (string-append baratin " with an HIP number"))
		 (set! marequete (string-append marequete dont "Coordonnées.[N° HIP]  not like '*'")))
	       ;; else
	       (begin
		 (set! baratin (string-append baratin ", with an HIP number"))
		 (set! marequete (string-append marequete  Et "Coordonnées.[N° HIP] not like '*'")))))


     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : caseorb = " caseorb)

     (if-t (and (string? caseorb) (string=? caseorb "ON"))
	   (set! erreurgeneral 1)
	   (if (= cocher 0)
	       (begin
		 (set! cocher 1)
		 (set! baratin (string-append baratin " with a calculated orbit"))
		 (set! marequete (string-append marequete dont "Coordonnées.Orb like 'OUI'")))
	       ;; else
	       (begin
		 (set! baratin (string-append baratin ", with a calculated orbit"))
		 (set! marequete (string-append marequete  Et "Coordonnées.Orb like 'OUI'")))))


     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casealfa = " casealfa)

     (if-t (and (string? casealfa) (string=? casealfa "ON"))
	   (set! erreurgeneral 1)
	   (set! alfamin AlphaMin)
	   (set! alfamax AlphaMax)
	   (if (or (string=? alfamin "") (string=? alfamax ""))
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give a min or a max Alpha ! ")))
	       ;; else
	       (begin

		 (set! iminresult (string->number alfamin))
		 (set! resulth (floor (/ iminresult 1000)))
		 (set! resultm (- iminresult (* resulth 1000)))
		 (set! resultm (floor (/ resultm 10)))
		 (set! results (- iminresult (* resulth 1000) (* resultm 10)))

		 (if-t (< resulth 1)
		       (set! resulth "00"))

		 (if-t (and (>= resulth 1) (< resulth 10))
		       (set! resulth (string-append "0" (number->string (fix resulth)))))

		 (if-t (< resultm 10)
		       (set! resultm (string-append "0" (number->string (fix resultm)))))

		 ;; checking that we have strings !!!
		 (if-t (not (string? resulth))
		       (set! resulth (number->string (fix resulth))))
		 (if-t (not (string? resultm))
		       (set! resultm (number->string (fix resultm))))

		 (set! results (number->string (fix results)))

		 (set! iminresult (string-append resulth " h " resultm "." results " mn"))

		 (set! imaxresult (string->number alfamax))
		 (set! resulth (floor (/ imaxresult 1000)))
		 (set! resultm (- imaxresult (* resulth 1000)))
		 (set! resultm (floor (/ resultm 10)))
		 (set! results (- imaxresult (* resulth 1000) (* resultm 10)))

		 (if-t (< resulth 1)
		       (set! resulth "00"))
		 (if-t (and (>= resulth 1) (< resulth 10))
		       (set! resulth (string-append "0" (number->string resulth))))
		 (if-t (< resultm 10)
		       (set! resultm (string-append "0" (number->string resultm))))

		 ;; checking that we have strings !!!
		 (if-t (not (string? resulth))
		       (set! resulth (number->string (fix resulth))))
		 (if-t (not (string? resultm))
		       (set! resultm (number->string (fix resultm))))

		 (set! results (number->string (fix results)))

		 (set! imaxresult (string-append resulth " h " resultm "." results " mn"))

		 (if (= cocher 0)
		     (begin
		       (set! cocher 1)
		       (set! baratin (string-append baratin  " with Alpha between " iminresult))
		       (set! baratin (string-append baratin " and " imaxresult))
		       (set! marequete (string-append marequete dont))
		       (set! marequete (string-append marequete "Coordonnées.[Alpha 2000] >= " alfamin " AND Coordonnées.[Alpha 2000] <= " alfamax)))
		     ;; else
		     (begin
		       (set! baratin (string-append baratin  ", with Alpha between " iminresult))
		       (set! baratin (string-append baratin " and " imaxresult))
		       (set! marequete (string-append marequete Et "Coordonnées.[Alpha 2000] >= " alfamin " AND Coordonnées.[Alpha 2000] <= " alfamax)))))))


     ;;  casedelta

     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casedelta = " casedelta)
     
     (if-t (and (string? casedelta) (string=? casedelta "ON"))
	   (set! erreurgeneral 1)
	   (set! deltamin DeltaMin)
	   (set! deltamax DeltaMax)
	   (if (or (string=? deltamin "") (string=? deltamax ""))
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give a min or a max Delta ! ")))
	       ;; else
	       (begin
		 (if (< (string->number deltamin) 0)
		     (set! sign "-")
		     (set! sign "&nbsp;"))
		 
		 (set! deminresult (abs (string->number deltamin)))
		 (set! resultd (floor (/ deminresult 100)))
		 (set! resultmi (- deminresult (* resultd 100)))

		 (if-t (< resultd 1)
		       (set! resultd "00"))

		 (if-t (and (>= resultd 1) (< resultd 10))
		       (set! resultd (string-append "0" (number->string resultd))))

		 (if-t (< resultmi 10)
		       (set! resultmi (string-append "0" (number->string resultmi))))

		 (if-t (number? resultd)
		       (set! resultd (number->string resultd)))

		 (if-t (number? resultmi)
		       (set! resultmi (number->string resultmi)))
		 
		 (set! deminresult (string-append sign resultd " ° " resultmi " '"))
		 
		 (if (< (string->number deltamax) 0)
		     (set! sign "-")
		     (set! sign "&nbsp;"))

		 (set! demaxresult (abs (string->number deltamax)))
		 (set! resultd (floor (/ demaxresult 100)))
		 (set! resultmi (- demaxresult (* resultd 100)))
		 
		 (if-t (< resultd 1)
		       (set! resultd "00"))

		 (if-t (and (>= resultd 1) (< resultd 10))
		       (set! resultd (string-append "0" (number->string resultd))))

		 (if-t (< resultmi 10)
		       (set! resultmi (string-append "0" (number->string resultmi))))

		 (if-t (number? resultd)
		       (set! resultd (number->string resultd)))

		 (if-t (number? resultmi)
		       (set! resultmi (number->string resultmi)))
		 
		 (set! demaxresult (string-append sign resultd " ° " resultmi " '"))

		 (if (= cocher 0)
		     (begin
		       (set! cocher 1)
		       (set! baratin (string-append baratin  " with Delta between " deminresult))
		       (set! baratin (string-append baratin " and " demaxresult))
		       (set! marequete (string-append marequete dont))
		       (set! marequete (string-append marequete "Coordonnées.[Delta 2000] >= " deltamin " AND Coordonnées.[Delta 2000] <= " deltamax)))
		     ;; else
		     (begin
		       (set! baratin (string-append baratin ", with Delta between " deminresult))
		       (set! baratin (string-append baratin " and " demaxresult))
		       (set! marequete (string-append marequete Et "Coordonnées.[Delta 2000] >= " deltamin " AND Coordonnées.[Delta 2000] <= " deltamax)))))))

     

     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casemag1 = " casemag1)

     (if-t (and (string? casemag1) (string=? casemag1 "ON"))
	   (set! erreurgeneral 1)
	   (set! mag1min Mag1Min)
	   (set! mag1max Mag1Max)
	   (if (or (string=? mag1min "") (string=? mag1max ""))
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur "  you forgot to give a min or a max magnitude ! ")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     (set! baratin (string-append baratin  " with mag1 between " mag1min " and " mag1max))
		     (set! marequete (string-append marequete dont))
		     ;;(set! marequete (string-append marequete "Cdbl(Coordonnées.mag1) >= " "Cdbl(" mag1min ")"))
		     (set! marequete (string-append marequete "CAST(Coordonnées.mag1 as DECIMAL(9,2)) >= " mag1min))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag1) <= "  "Cdbl(" mag1max ")")))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag1 as DECIMAL(9,2)) <= "  mag1max)))
		   ;; else
		   (begin
		     (set! baratin (string-append baratin ", with mag1 between " mag1min))
		     (set! baratin (string-append baratin " and " mag1max))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag1) >= " "Cdbl(" mag1min ")"))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag1 as DECIMAL(9,2)) >= " mag1min))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag1) <= " "Cdbl(" mag1max ")"))))))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag1 as DECIMAL(9,2)) <= "  mag1max))))))


     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casemag2 = " casemag2)

     ;; casemag2
     (if-t (and (string? casemag2) (string=? casemag2 "ON"))
	   (set! erreurgeneral 1)
	   (set! mag2min Mag2Min)
	   (set! mag2max Mag2Max)
	   (if (or (string=? mag2min "") (string=? mag2max ""))
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur " you forgot to give a min or a max magnitude !  ")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     (set! baratin (string-append baratin " avec mag2 comprise entre " mag2min " et " mag2max))
		     (set! marequete (string-append marequete dont))
		     ;;(set! marequete (string-append marequete "Cdbl(Coordonnées.mag2) >= " "Cdbl(" mag2min ")"))
		     (set! marequete (string-append marequete "CAST(Coordonnées.mag2 as DECIMAL(9,2)) >= " mag2min))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag2) <= "  "Cdbl(" mag2max ")")))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag2 as DECIMAL(9,2)) <= "  mag2max)))
		   ;; else
		   (begin
		     (set! baratin (string-append baratin ", avec mag2 comprise entre " mag2min))
		     (set! baratin (string-append baratin " et " mag2max))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag2) >= " "Cdbl(" mag2min ")"))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag2 as DECIMAL(9,2)) >= " mag2min))
		     ;;(set! marequete (string-append marequete Et "Cdbl(Coordonnées.mag2) <= " "Cdbl(" mag2max ")"))))))
		     (set! marequete (string-append marequete Et "CAST(Coordonnées.mag2 as DECIMAL(9,2)) <= "  mag2max))))))

		     
     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casediffmag = " casediffmag)

     ;; casediffmag
     (if-t (and (string? casediffmag) (string=? casediffmag "ON"))
	   (set! erreurgeneral 1)
	   (set! diffmag Mag2Mag1)
	   (if (string=? diffmag "")
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur  "  you forgot to give a magnitude difference value ! ")))
	       ;; else
	       (if (= cocher 0)
		   (begin
		     (set! cocher 1)
		     (set! baratin (string-append baratin " avec mag2 - mag1 >= " diffmag))
		     (set! marequete (string-append marequete dont))
		     ;;(set! marequete (string-append marequete  "(Cdbl(Coordonnées.mag2) - Cdbl(Coordonnées.mag1)) >= " "Cdbl(" diffmag ")")))
		     (set! marequete (string-append marequete  "(CAST(Coordonnées.mag2 as DECIMAL(9,2)) - CAST(Coordonnées.mag1 as DECIMAL(9,2))) >= " diffmag)))
		   ;; else
		   (begin
		     (set! baratin (string-append baratin ", avec mag2 - mag1 >= " diffmag))
		     ;;(set! marequete (string-append marequete Et "(Cdbl(Coordonnées.mag2) - Cdbl(Coordonnées.mag1)) >= " "Cdbl(" diffmag ")" ))))))
		     (set! marequete (string-append marequete Et "(CAST(Coordonnées.mag2 as DECIMAL(9,2)) - CAST(Coordonnées.mag1 as DECIMAL(9,2))) >= " diffmag))))))



     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : casetype = " casetype)

     

     (if-t (and (string? casetype) (string=? casetype "ON"))
	   (set! erreurgeneral 1)
	   (if (or (string=? type1 "") (string=? type2 ""))
	       (begin
		 (set! flagerreur 1)
		 (set! baraterreur (string-append baraterreur  " you forgot to give a min or a max spectral type ! ")))
	       ;; else
	       (begin

		 (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : type1 = " type1)
		 (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : type2 = " type2)

		 (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : Nom = " Nom)

		 (if (equal? "B5" type1)
		     (debug-only display-nl "ResultatGeneralAFKawa : work : equal? test TRUE")
		     (debug-only display-nl "ResultatGeneralAFKawa : work : equal? test FALSE"))

		 (if (eqv? "B5" type1)
		     (debug-only display-nl "ResultatGeneralAFKawa : work : eqv? test TRUE")
		     (debug-only display-nl "ResultatGeneralAFKawa : work : eqv? test FALSE"))

		 ;;(display (string-append "|" (type1:getClass:getName) "|"))
		 (debug-only display "ResultatGeneralAFKawa : work : type1 is of type : ") 
		 (debug-only display   (invoke type1:class 'getName) )
		 (debug-only newline)

		 (debug-only display "ResultatGeneralAFKawa : work : B5 is of type : ") 
		 (debug-only display   (invoke "B5":class 'getName) )
		 (debug-only newline)

		 ;; (if (eqv? (gnu.lists.FString:toString "B5") type1)
		 ;; 	 (display-nl "ResultatGeneralAFKawa : work : eqv? gnu.lists.FString:toString test TRUE")
		 ;; 	 (display-nl "ResultatGeneralAFKawa : work : eqv? gnu.lists.FString:toString test FALSE"))

		 ;; (if (eqv? (gnu.text.Char:toString "B5") type1)
		 ;; 	 (display-nl "ResultatGeneralAFKawa : work : eqv? gnu.lists.FString:toString test TRUE")
		 ;; 	 (display-nl "ResultatGeneralAFKawa : work : eqv? gnu.lists.FString:toString test FALSE"))

		 (if (eq? "B5" type1)
		     (debug-only display-nl "ResultatGeneralAFKawa : work : eq? test TRUE")
		     (debug-only display-nl "ResultatGeneralAFKawa : work : eq? test FALSE"))


		 (debug-only display "ResultatGeneralAFKawa : work : nutype1 is of type : ") 
		 (debug-only display   (invoke nutype1:class 'getName) )
		 (debug-only newline)

		 (set! nutype1
		       (case-member type1
				    (("O") 1) ;; java.lang.String
				    (("O0") 2)
				    (("O1") 3)
				    (("O2") 4)
				    (("O3") 5)
				    (("O4") 6)
				    (("O5") 7)
				    (("O6") 8)
				    (("O7") 9)
				    (("O8") 10)
				    (("O9") 11)
				    (("B") 12)
				    (("B0") 13)
				    (("B1") 14)
				    (("B2") 15)
				    (("B3") 16)
				    (("B4") 17)
				    (("B5") 18)
				    (("B6") 19)
				    (("B7") 20)
				    (("B8") 21)
				    (("B9") 22)
				    (("A") 23)
				    (("A0") 24)
				    (("A1") 25)
				    (("A2") 26)
				    (("A3") 27)
				    (("A4") 28)
				    (("A5") 29)
				    (("A6") 30)
				    (("A7") 31)
				    (("A8") 32)
				    (("A9") 33)
				    (("F") 34)
				    (("F0") 35)
				    (("F1") 36)
				    (("F2") 37)
				    (("F3") 38)
				    (("F4") 39)
				    (("F5") 40)
				    (("F6") 41)
				    (("F7") 42)
				    (("F8") 43)
				    (("F9") 44)
				    (("G") 45)
				    (("G0") 46)
				    (("G1") 47)
				    (("G2") 48)
				    (("G3") 49)
				    (("G4") 50)
				    (("G5") 51)
				    (("G6") 52)
				    (("G7") 53)
				    (("G8") 54)
				    (("G9") 55)
				    (("K") 56)
				    (("K0") 57)
				    (("K1") 58)
				    (("K2") 59)
				    (("K3") 60)
				    (("K4") 61)
				    (("K5") 62)
				    (("K6") 63)
				    (("K7") 64)
				    (("K8") 65)
				    (("K9") 66)
				    (("M") 67)
				    (("M0") 68)
				    (("M1") 69)
				    (("M2") 70)
				    (("M3") 71)
				    (("M4") 72)
				    (("M5") 73)
				    (("M6") 74)
				    (("M7") 75)
				    (("M8") 76)
				    (("M9") 77)
				    (else #;=> (begin
						 (display-nl "display values:")
						 (dv type1)
						 (dv nutype1)
						 (display "WARNING : ResultatGeneralAFKawa : work : CASE type1 in ELSE")
						 (newline)
						 '()))))
		 
		 (dv nutype1)
		 
		 (set! nutype2
		       (case-member type2
				    (("O") 1)
				    (("O0") 2)
				    (("O1") 3)
				    (("O2") 4)
				    (("O3") 5)
				    (("O4") 6)
				    (("O5") 7)
				    (("O6") 8)
				    (("O7") 9)
				    (("O8") 10)
				    (("O9") 11)
				    (("B") 12)
				    (("B0") 13)
				    (("B1") 14)
				    (("B2") 15)
				    (("B3") 16)
				    (("B4") 17)
				    (("B5") 18)
				    (("B6") 19)
				    (("B7") 20)
				    (("B8") 21)
				    (("B9") 22)
				    (("A") 23)
				    (("A0") 24)
				    (("A1") 25)
				    (("A2") 26)
				    (("A3") 27)
				    (("A4") 28)
				    (("A5") 29)
				    (("A6") 30)
				    (("A7") 31)
				    (("A8") 32)
				    (("A9") 33)
				    (("F") 34)
				    (("F0") 35)
				    (("F1") 36)
				    (("F2") 37)
				    (("F3") 38)
				    (("F4") 39)
				    (("F5") 40)
				    (("F6") 41)
				    (("F7") 42)
				    (("F8") 43)
				    (("F9") 44)
				    (("G") 45)
				    (("G0") 46)
				    (("G1") 47)
				    (("G2") 48)
				    (("G3") 49)
				    (("G4") 50)
				    (("G5") 51)
				    (("G6") 52)
				    (("G7") 53)
				    (("G8") 54)
				    (("G9") 55)
				    (("K") 56)
				    (("K0") 57)
				    (("K1") 58)
				    (("K2") 59)
				    (("K3") 60)
				    (("K4") 61)
				    (("K5") 62)
				    (("K6") 63)
				    (("K7") 64)
				    (("K8") 65)
				    (("K9") 66)
				    (("M") 67)
				    (("M0") 68)
				    (("M1") 69)
				    (("M2") 70)
				    (("M3") 71)
				    (("M4") 72)
				    (("M5") 73)
				    (("M6") 74)
				    (("M7") 75)
				    (("M8") 76)
				    (("M9") 77)
				    (else #;=> (begin
						 (display "WARNING : ResultatGeneralAFKawa : work : CASE type2 in ELSE")
						 (newline)
						 '()))))
		 
		 (if (= cocher 0)
		     (begin
		       (set! cocher 1)
		       (set! baratin (string-append baratin  " with spectral types between " type1 " and " type2))
		       (set! marequete (string-append marequete dont))
		       (set! marequete (string-append marequete  "Coordonnées.[N°Type] >= "
						      (number->string nutype1) " AND Coordonnées.[N°Type] <= "
						      (number->string nutype2))))
		     ;; else
		     (begin
		       (set! baratin (string-append baratin   ", with spectral types between " type1 " and " type2))
		       (set! marequete (string-append marequete Et "Coordonnées.[N°Type] >= "
						      (number->string nutype1) " AND Coordonnées.[N°Type] <= "
						      (number->string nutype2))))))))
     
     
     ;; partie HTML
     
     (if (or (= flagerreur 1) (= erreurgeneral 0))
	 
	 (then-block
	  
	  (if-t (= erreurgeneral 0)
		(set! baraterreur (string-append baraterreur " You didn't tick any box !!  ")))
	  
	  (set! res
		(gnu.lists.FString:toString
		 (string-append
		  res 
		  "<h1 align=\"center\"><font color=\"#0000FF\">SIDONIe - Statistical Results</font></h1>"
		  "<div align=\"center\">"
		  "<center>"
		  "<table width=\"85%\" border=\"3\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"
		  "     <tr>"
		  "          <th width=\"82%\"><font color=\"#0000FF\">" baraterreur "<br>" "</font></th>"
		  "     </tr>"
		  "</table>"
		  "</center>"
		  "</div>"))))

	 (else-block
	  
	  (set! marequete (string-append marequete monordre))

	  ;; converting 
	  (set! marequete (sql-server->mysql-server-syntax marequete))

	  (display-msg-var-nl  "ResultatGeneralAFKawa : work : Voila la valeur SQL de la requète : marequete = " marequete)
	  (eu.oca.DataBase:executeQueryStatic 
	   marequete
	   ;;(gnu.lists.FString:toString marequete)
	   "Stats")
	  (set! rs eu.oca.DataBase:resultSetStats)
	  (rs:first)
	  (set! total 0)
	  (set! res
		 (gnu.lists.FString:toString
		  (string-append
		   res 
		   "<h1 align=\"center\"><font color=\"#0000FF\">SIDONIe - Statistical Results</font></h1>"
		   "<div align=\"center\">"
		   "  <center>"
		   "    <table width=\"85%\" border=\"3\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"
		   "          <tr>"
		   "              <th width=\"82%\"><font color=\"#0000FF\">" baratin "<br></font></th>"
		   "          </tr>"
		   "    </table>"
		   "  </center>"
		   "</div>"
		   "<P>"
		   "<P>"
		   "<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">"
		   "<tr>"
		   "    <th><font color=\"#000080\">Name</font></th>"
                   "    <th><font color=\"#000080\">Alpha 2000</font></th>"
		   "    <th><font color=\"#000080\">Delta 2000</font></th>"
		   "    <th><font color=\"#000080\">BD #</font></th>"
		   "    <th><font color=\"#000080\">ADS #</font></th>"
		   "    <th><font color=\"#000080\">HIP #</font></th>"
		   "    <th><font color=\"#000080\">mag 1</font></th>"
		   "    <th><font color=\"#000080\">mag 2</font></th>"
		   "    <th><font color=\"#000080\">Spectral type</font></th>"
		   "</tr>")))


	  (rs:beforeFirst)

	  (when (rs:next) ;; test SQL empty result set

		;; DO WHILE LOOP
		
		(while (not (rs:isAfterLast))
		       
		       (set! total (+ total 1))
		       
		       (append-string-to-result "<tr>")
		       
		       
		       ;; 0 :Name
		       (set! result (rs:getString 1))
		       
		       (if (or (rs:wasNull) (string-null? result))
			   
			   (then-block
			    (set! result "&nbsp;")
			    (append-string-to-result "<td>")
			    (append-string-to-result result)
			    (append-string-to-result "</td>"))
			   
			   (else-block
			    (append-string-to-result "<td>")
			    (append-string-to-result (string-upcase result))
			    (append-string-to-result "</td>")))
		       
		       ;; 1  : alpha 2000
		       (set! result (rs:getDouble 2))
		       
		       (if (rs:wasNull)
			   (set! result "&nbsp;")
			   (begin
			     (set! iresult (floor result))
			     (set! resulth (fix (/ iresult 1000)))
			     ;;(set! resulth (floor (/ iresult 1000)))
			     (set! resultm (- iresult (* resulth 1000)))
			     (set! resultm (fix (/ resultm 10)))
			     ;;(set! resultm (floor (/ resultm 10)))
			     (set! results (fix (- iresult (* resulth 1000) (* resultm 10))))
			     ;;(set! results (- iresult (* resulth 1000) (* resultm 10)))
			     (if-t (< resulth 1)
				   (set! resulth "00"))
			     (if-t (and (>= resulth 1) (< resulth 10))
				   (set! resulth (string-append "0" (number->string resulth))))
			     (if-t (< resultm 10)
				   (set! resultm (string-append "0" (number->string resultm))))
			     (if-t (number? resulth)
				   (set! resulth (number->string resulth)))
			     (if-t (number? resultm)
				   (set! resultm (number->string resultm)))
			     (set! results (number->string results))
			     (set! result (string-append resulth " h " resultm "." results " mn"))))

		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       ;; 2 : Delta
		       (set! result (rs:getDouble 3))
		       (if (rs:wasNull)
			   (set! result "&nbsp;")
			   (begin
			     (if (< result 0)
				 (set! sign "-")
				 (set! sign "&nbsp;"))
			     (set! aresult (abs result))
			     ;;(set! resultd (floor (/ aresult 100)))
			     (set! resultd (fix (/ aresult 100)))
			     ;;(set! resultmi (- aresult (* resultd 100)))
			     (set! resultmi (fix (- aresult (* resultd 100))))
			     (if-t (< resultd 1)
				   (set! resultd "00"))
			     (if-t (and (>= resultd 1) (< resultd 10))
				   (set! resultd (string-append "0" (number->string resultd))))
			     (if-t (< resultmi 10)
				   (set! resultmi (string-append "0" (number->string resultmi))))
			     (if-t (number? resultd)
				   (set! resultd (number->string resultd)))
			     (if-t (number? resultmi)
				   (set! resultmi (number->string resultmi)))
			     (set! result (string-append sign resultd " ° " resultmi " '")))) 
		       
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")
		       
		       ;; 3
		       (set! result (rs:getString 4))
		       (if-t (rs:wasNull)
			     (set! result "&nbsp;"))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       ;; 4
		       (set! result (rs:getString 5))
		       (if-t (rs:wasNull)
			     (set! result "&nbsp;"))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       ;; 5
		       (set! result (rs:getString 6))
		       (if-t (rs:wasNull)
			     (set! result "&nbsp;"))
		       (if-t (string=? result "*")
			     (set! result "&nbsp;"))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")
		       
		       ;; 6 : mag1
		       (set! result (rs:getString 7))
		       (if-t (rs:wasNull)
			     (set! result "&nbsp;"))
		       (if-t (string=? result "00.")
			     (set! result "&nbsp;"))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       ;; 7 : mag2
		       (set! result (rs:getString 8))
		       (if-t (rs:wasNull)
			     (set! result "&nbsp;"))
		       (if-t (string=? result "00.")
			     (set! result "&nbsp;"))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       ;; 8 : Spectre
		       (set! result (rs:getString 9))
		       (if (rs:wasNull)
			   (set! result "&nbsp;")
			   (if (string=? result "-")
			       (set! result "&nbsp;")
			       (set! result (string-upcase result))))
		       (append-string-to-result "<td>")
		       (append-string-to-result result)
		       (append-string-to-result "</td>")

		       (append-string-to-result "</tr>")

		       (rs:next) ;; rs.Movenext in ASP
		       
		       ) ;; end WHILE (Do While ... Loop) 

		) ;; end when (test empty SQL result set)



	  (append-string-to-result 
	   (string-append
	    "</table>
             <P>
             <P>
             <table width=\"60%\" border=\"3\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">
                 <tr>
                     <th><font color=\"#0000FF\"> Number of selected objects<br></font></th>
                     <th>" (number->string total) "</th>
                 </tr>
             </table>"))

	  ) ;; end (else
	 ) ;; end (if (or (= flagerreur 1) (= erreurgeneral 0))


     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : baraterreur = " baraterreur)
     (debug-only display-msg-var-nl  "ResultatGeneralAFKawa : work : baratin = " baratin)


     ;; we are in jersey/ path of the URL
     (append-string-to-result 
	    "<P>
             <P>
             <table border=\"0\" width=\"95%\">
                <tr>
                    <td valign=\"top\"><a href=\"../SidonieObject.htm\"> <img border=\"0\" src=\"../retour_blanc.gif\" width=\"26\" height=\"26\"></a>
       
                    <font size=\"2\"><em>Search on an object</em></font></td>

	            <td valign=\"top\"><a href=\"../SidonieStatistic.htm\"><img border=\"0\" src=\"../retour_blanc.gif\" width=\"26\" height=\"26\"></a>

                    <font size=\"2\"><em>Statistical Search</em></font></td>
                    </td>
                </tr>
            </table>
        </body>
    </html>")


     ) ;; end let*
   
   (eu.oca.DataBase:closeStatic)
   (display "ResultatGeneralAFKawa : work : eu.oca.DataBase:closeStatic PASSED")
   (newline)

   ;; (eu.oca.DataBase:deregisterDriverStatic)
   ;; (display "ResultatGeneralFKawa : work : eu.oca.DataBase:deregisterDriverStatic PASSED")
   ;; (newline)

   
   ;;(display-msg-var-nl  "ResultatGeneralAFKawa : work : res = " res)
   
   res) ;; return a String
  
  
  ;; other Class definition functions

  ((sql-server->mysql-server-syntax query) ;; replace [ and ] by `
   (regex-replace* (regex "\\]") (regex-replace* (regex "\\[") query "`") "`"))

  ((append-string-to-result str) ;; append a string to result
   (set! res
	 (gnu.lists.FString:toString
	  (string-append res str))))

  ((string-null? str)
   (string=? str ""))

  ((fix x)
   (debug-only display-nl "ResultatGeneralAFKawa.scm :: entering fix")
   (let ((r (inexact->exact (truncate x))))
     (debug-only display "ResultatGeneralFKawa.scm :: fix :: r =")
     (debug-only display r)
     (debug-only newline)
    r))
  
  ) ;; end of class










