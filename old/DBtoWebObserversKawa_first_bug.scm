;; Kawa Scheme code for java virtual machine and tomcat web server

;; author: Damien Mattei

;; compilation method:

;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl -C DBtoWebObserversKawa.scm
;; 
;; to add more tail-calls optimisations:
;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --full-tailcalls -C DBtoWebObserversKawa.scm 
;; jar cf ~/Dropbox/KawaFunctProg.jar eu

;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --output-format html -C DBtoWebObserversKawa.scm


(module-name "eu.oca.kawafunct.DBtoWebObserversKawa")

(require 'regex)

(include-relative  "../git/LOGIKI/lib/first-and-rest.scm")
(include-relative  "../git/LOGIKI/lib/syntactic-sugar.scm") ;; YES in kawa you can include files from other schemes...
(include-relative  "../git/LOGIKI/lib/display.scm")
(include-relative  "../git/LOGIKI/lib/case.scm") ;; for CASE with STRINGS
(include-relative  "../git/LOGIKI/lib/list.scm") ;; for remove-last used by map.scm
(include-relative  "../git/LOGIKI/lib/set.scm") ;; for map-nil*
(include-relative  "../git/LOGIKI/lib/map.scm") ;; for map-nil*




(define-simple-class DBtoWebObserversKawa ()

 
  (Nom ::java.lang.String init-keyword: Nom:)
  (res ::java.lang.String init-keyword: res:)
  
  ((*init*
	   (nomParam ::java.lang.String)
	   )
   
   (set! Nom nomParam)
   
   #;(work))

  
  ;; Need a default constructor as well.
  ((*init*) #!void)

  
  ((work) ::java.lang.String ;; do the job:

   (eu.oca.DataBase:searchDriverStatic)
   (display "DBtoWebObserversKawa : work : eu.oca.DataBase:searchDriverStatic PASSED")
   (newline)
   
   (eu.oca.DataBase:connectStatic)
   (display "DBtoWebObserversKawa : work : eu.oca.DataBase:connectStatic PASSED")
   (newline)

   (eu.oca.DataBase:createStatementStatic) ;; i put the statement here if it's true it can be reused for multiple SQL queries
   (display "DBtoWebObserversKawa : work : eu.oca.DataBase:createStatementStatic PASSED")
   (newline)

   
   (let* ((marequete "SELECT * FROM Obs ORDER BY Auteur")
	  
	  (rs ::java.sql.ResultSet #!null)
	  (total '())
	  (result '())
	  ;; first we fetch the data "outremer" and parse the file to get the observers code
	  (wds-url "http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewref.txt")
	  ;; (define wds-url "http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewref.txt")
	  (wds-data-str &<{&[wds-url]}) ;; could take a few seconds to GET file
	  ;; (define wds-data-str &<{&[wds-url]})
	  ;;(str1 (substring wds-data-str 0 30))
	  (len-wds-data-str (string-length wds-data-str))
	  
	  ;; get and split using positions of the minus ----- lines
	  (pos-minus  
	   (regex-match-positions
	    "-----------------------------------------------------------------------------------------------------------------------------" 
	    wds-data-str))
	  
	  (pos-minus-end (cdr (car pos-minus)))
	  
	  (wds-data-str-minus-1 (substring
				 wds-data-str
				 pos-minus-end
				 (- (string-length wds-data-str) 1)))
	  
	  (pos-minus2  
	   (regex-match-positions
	    "-----------------------------------------------------------------------------------------------------------------------------" 
	    wds-data-str-minus-1))
	  
	  (pos-minus2-end (cdr (car pos-minus2)))
	  
	  (wds-data-str-minus-2 (substring
				 wds-data-str-minus-1
				 pos-minus2-end
				 (- (string-length wds-data-str-minus-1) 1)))
	  
	  ;; get and split using positions of the equals ====== line
	  (pos-equals
	   (regex-match-positions
	    "========================================================================================================"
	    wds-data-str-minus-2))

	  (pos-equals-begin (car (car pos-equals)))

	  (wds-data-str-equals (substring
				wds-data-str-minus-2
				0
				(- pos-equals-begin 1)))

	  ;;(wds-data-str-split (regex-split (string #\return) wds-data-str)) 
	  (wds-data-str-split (regex-split (string #\linefeed) wds-data-str-equals))
	  ;; (define wds-data-str-split (regex-split (string #\linefeed) wds-data-str))

	  ;; remove null string
	  (rgx (begin 
		 (display-nl  "DBtoWebObserversKawa : work : creating regex.")
		 (regex "^[a-zA-Z]")))

	  (tst-space-string
	   (lambda (s)
	     (if (regex-match rgx s)
		 s
		 '())))

	  (wds-data-str-no-spaces 
	   (begin
	     (display-nl  "DBtoWebObserversKawa : work : running  map-nil-iter-optim-tail-calls-call....")
	     ( map-nil-iter-optim-tail-calls-call tst-space-string wds-data-str-split )))

	  (html-literal-table-rows '()) ;; rows list of the table of observers
	  (html-literal-table-data-observer '()) ;; table data : observer
	  (html-literal-table-data-code '()) ;; table data : code
	  (literal-rows-list '()) ;; list of the litterals rows 
	  (html-literal-table '()) ;; table of observers
	  (html-literal '()) ;; the whole set of HTML literals
	  (html-literal-str "") ;; the string of the whole set of HTML literals
	  ) ;; end of LET


     (display-nl  "DBtoWebObserversKawa : work : after let* declarations.")
     ;;(display-msg-var-nl  "DBtoWebObserversKawa : work : str1 = " str1)
     (display-msg-var-nl  "DBtoWebObserversKawa : work : length wds-data-str = " len-wds-data-str)
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (car wds-data-str-split) = " (car wds-data-str-split))
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (substring wds-data-str-minus-1 0 50) = " (substring wds-data-str-minus-1 0 50))
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (substring wds-data-str-minus-2 0 50) = " (substring wds-data-str-minus-2 0 50))
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (substring wds-data-str-equals 0 50) = " (substring wds-data-str-equals 0 50))
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (cadr wds-data-str-split) = " (cadr wds-data-str-split))
     (display-msg-var-nl  "DBtoWebObserversKawa : work : (car wds-data-str-no-spaces) = " (car wds-data-str-no-spaces))

       
     
     ;; partie HTML
     
    

     (set! res 
	   (gnu.lists.FString:toString
	    (string-append
	     "<HTML DIR=LTR>"
	     "      <HEAD>"
	     "            <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html;\">"
	     
	      #;"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">"
	      ;;"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"


	     "            <TITLE>Observateurs - Codes</TITLE>"
	     "      </HEAD>"
	     "      <body bgcolor=\"#FFFFC0\">"
	     "            <p align=center><b><font color=\"#000080\"><i>Codes utilisés pour les Observateurs : classement par ordre alphabétique des codes</i></font></b>"
	     "            <p>&nbsp;"
	     "            <TABLE align=center border=\"0\" width=\"80%\">"
	     "                   <TR>"
	     "                       <TD valign=left><a href=\"SidonieDescriptionF.html#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
	     "                           <font size=\"2\"><em>Tout savoir...</em></font>"
	     "                       </TD>"
	     "                   </TR>"
	     "                   <TR>"
	     "                       <TD valign=left><a href=\"ObservateursCodes.html\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
	     "                           <font size=\"2\"><em>Classement par noms</em></font>"
	     "                       </TD>"
	     "                   </TR>")))
	     ;;"                   <TD align=center>")))
	      
     
     (display-msg-var-nl  "DBtoWebObserversKawa : work : res = " res)

     
     ;; converting from SQL server to MySQL (MariaDB)
     (set! marequete (sql-server->mysql-server-syntax marequete))

     (display-msg-var-nl  "DBtoWebObserversKawa : work : Voila la valeur SQL de la requète : marequete = " marequete)
     
     (eu.oca.DataBase:executeQueryStatic 
	   marequete
	   "Observateurs")

     (set! rs eu.oca.DataBase:resultSetObservateurs)
     
     (rs:first)

     (set! total 0)
     
     (rs:beforeFirst)
     
     (when (rs:next) ;; test SQL empty result set
	   
	   ;; DO WHILE LOOP
		
	   (while (not (rs:isAfterLast))
		       
		  (set! total (+ total 1))
		  
		  ;;(append-string-to-result "<tr>")
		       
		       
		  ;; 0 : code
		  (set! result (rs:getString 1))
		  
		  (if (or (rs:wasNull) (string-null? result))
		      
		      (display-nl  "DBtoWebObserversKawa : work : result (code) : string or result set is null")
		      			   
		      (begin
			;;(append-string-to-result "<td>")
			(set! html-literal-table-data-code
			      (html:td result))
			
			(display-msg-var-nl  "DBtoWebObserversKawa : work : result (code) = " result)
			;;(append-string-to-result (string-upcase result))
			#;(append-string-to-result "</td>")))
		  
		  
		  ;; 1 : auteur (Observer)
		  (set! result (rs:getString 2))
		  
		  (if (rs:wasNull)
		      (set! result "NuLL"))
		  
		  ;;(append-string-to-result "<td>")
		  
		  (set! html-literal-table-data-observer 
			(html:td result))

		  (display-msg-var-nl  "DBtoWebObserversKawa : work : result (Observer) = " result)
		  ;;(append-string-to-result result)
		  ;;(append-string-to-result "</td>")
		  
		  (set! html-literal-table-rows
			(html:tr
			  html-literal-table-data-code
			  html-literal-table-data-observer))

		  (display-msg-var-nl  "DBtoWebObserversKawa : work : html-literal-table-rows = " html-literal-table-rows)

		  (set! literal-rows-list
			(cons html-literal-table-rows literal-rows-list))

		  (rs:next) 
		  
		  ) ;; end WHILE (Do While ... Loop) 
	   
	   ) ;; end when (test empty SQL result set)


     (display-msg-var-nl  "DBtoWebObserversKawa : work : total = " total)
     
     (display-msg-var-nl  "DBtoWebObserversKawa : work :literal-rows-list  = " literal-rows-list)

     (set! literal-rows-list
	   (reverse literal-rows-list)) ;; revert the list so it's well ordered to display
     
      (display-msg-var-nl  "DBtoWebObserversKawa : work :(reverse literal-rows-list)   = " literal-rows-list)

     ;; HTML table 
     (set! html-literal-table 
	   (apply html:table literal-rows-list))

     ;; HTML
     (set! html-literal
	   (html:td align: "center" html-literal-table))

     (set! html-literal-str (html-literal:toString))

     (display-msg-var-nl  "DBtoWebObserversKawa : work : html-literal-str = " html-literal-str)

     (display-msg-var-nl  "DBtoWebObserversKawa : work : res = " res)

     (append-string-to-result html-literal-str)
       
     ;; we are in jersey/ path of the URL
     (append-string-to-result
      (string-append
      "                  <TD valign=bottom><a href=\"SidonieDescriptionF.html#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
      "                          <font size=\"2\"><em>Tout savoir...</em></font></TD>"
      ;; unclosed table (verifier version anglaise)
      ;;"          </TR>"
      "          </TABLE>"
      "      </BODY>"
      "</HTML>"))

      (display-msg-var-nl  "DBtoWebObserversKawa : work : res = " res)

     ) ;; end let*
   
   (eu.oca.DataBase:closeStatic)
   (display "DBtoWebObserversKawa : work : eu.oca.DataBase:closeStatic PASSED")
   (newline)

   ;; (eu.oca.DataBase:deregisterDriverStatic)
   ;; (display "ResultatGeneralFKawa : work : eu.oca.DataBase:deregisterDriverStatic PASSED")
   ;; (newline)

   
   (display-msg-var-nl  "DBtoWebObserversKawa : work : res = " res)
   
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
   (display-nl "DBtoWebObserversKawa.scm :: entering fix")
   (let ((r (inexact->exact (truncate x))))
     (display "ResultatGeneralFKawa.scm :: fix :: r =")
     (display r)
     (newline)
    r))

  
  ) ;; end of class










