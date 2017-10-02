;; Kawa Scheme code for java virtual machine and tomcat web server

;; author: Damien Mattei

;; compilation method:

;; CURRENT USE:

;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --output-format html -C DBtoWebObserversKawa.scm

;; others:

;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl -C DBtoWebObserversKawa.scm
;; 
;; to add more tail-calls optimisations:
;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --full-tailcalls -C DBtoWebObserversKawa.scm 
;; jar cf ~/Dropbox/KawaFunctProg.jar eu

;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --output-format html -C DBtoWebObserversKawa.scm
;;
;; java -cp /home/mattei/kawa-2.4/lib/kawa.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --output-format html -C DBtoWebObserversKawa.scm
;;
;; compilation with full tail calls optimisation
;; java -cp /usr/local/share/java/kawa-2.1.jar:/home/mattei/NetBeansProjects/Sidonie/build/web/WEB-INF/classes kawa.repl --full-tailcalls --output-format html -C DBtoWebObserversKawa.scm

(module-name "eu.oca.kawafunct.DBtoWebObserversKawa")

;;(import java.util.Properties)

(require 'regex)
;;(require 'xml)

(require 'srfi-95) ;; for sorting

(include-relative  "../git/LOGIKI/lib/first-and-rest.scm")
(include-relative  "../git/LOGIKI/lib/syntactic-sugar.scm") ;; YES in kawa you can include files from other schemes...
(include-relative  "../git/LOGIKI/lib/display.scm")
(include-relative  "../git/LOGIKI/lib/debug.scm") ;; for debug
(include-relative  "../git/LOGIKI/lib/case.scm") ;; for CASE with STRINGS
(include-relative  "../git/LOGIKI/lib/list.scm") ;; for remove-last used by map.scm
(include-relative  "../git/LOGIKI/lib/set.scm") ;; for map-nil*
(include-relative  "../git/LOGIKI/lib/map.scm") ;; for map-nil*


;; local macro(s)
(define-syntax append-string-to-result!
  (syntax-rules ()
    ((_ var str)
     (set! var
	   (gnu.lists.FString:toString
	    (string-append var str))))))


(define-simple-class DBtoWebObserversKawa ()

 
  (WebAppsDir ::java.lang.String init-keyword: WebAppsDir:)
  (res ::java.lang.String init-keyword: res:)
  ;;(debug-mode :: java.lang.Boolean init-keyword: debug-mode:)
  
  ((*init*
    (WebAppsDirParam ::java.lang.String)
    )

   (display "Sidonie : DBtoWebObserversKawa : *init* : (WebAppsDirParam ::java.lang.String)")
   (newline)
   (set! WebAppsDir WebAppsDirParam)
   ;;(set! debug-mode #t)
   
   #;(work))

  
  ;; Need a default constructor as well.
  ((*init*) #!void)

  
  ((work) ::java.lang.String ;; do the job:

   (eu.oca.DataBase:searchDriverStatic)
   (display "Sidonie : DBtoWebObserversKawa : work : eu.oca.DataBase:searchDriverStatic PASSED")
   (newline)
   
   (eu.oca.DataBase:connectStatic)
   (display "Sidonie : DBtoWebObserversKawa : work : eu.oca.DataBase:connectStatic PASSED")
   (newline)

   (eu.oca.DataBase:createStatementStatic) ;; i put the statement here if it's true it can be reused for multiple SQL queries
   (display "Sidonie : DBtoWebObserversKawa : work : eu.oca.DataBase:createStatementStatic PASSED")
   (newline)

   
   (let* ((marequete "SELECT * FROM Obs ORDER BY Auteur")
	  
	  (rs ::java.sql.ResultSet #!null)
	  (total '())
	  (result '())


	  ;; first we fetch the data "outremer" and parse the file to get the observers code
	  (wds-url (begin
		     (display-nl  "Sidonie : DBtoWebObserversKawa : work : fetching http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewref.txt ... could take a few seconds to GET file ...")
		     "http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewref.txt"))
	  ;; (define wds-url "http://ad.usno.navy.mil/wds/Webtextfiles/wdsnewref.txt")

	  (appName "Sidonie")
	   ;; filename separator
	  (fileSep (begin
		     (display-nl  "Sidonie : DBtoWebObserversKawa : work : before java.lang.System:getProperty")
		     (java.lang.System:getProperty "file.separator")))
	  (fs fileSep)

	  (wds-file (string-append WebAppsDir
				   fs
				   appName
				   fs
				   "wdsnewref.txt"))

	  (wds-data-str 
	   (if (file-exists? wds-url)
	       &<{&[wds-url]} ;; could take a few seconds to GET file
	       (begin
		 (display-nl  
		  (string-append "Sidonie : DBtoWebObserversKawa : work : WARNING : "
				 wds-url 
				 " could not be reached !!!! => defaulting to local file."))
		 (if (file-exists? wds-file)
		     &<{&[wds-file]}
		     (string-append "Sidonie : DBtoWebObserversKawa : work : CRITICAL : "
				    wds-file 
				    " does not exist !!! => "
				    appName
				    " will not be able to start.")))))
		 
	  ;; (define wds-data-str &<{&[wds-url]})
	  ;;(str1 (substring wds-data-str 0 30))
	  (len-wds-data-str (begin
			      (display-nl  "Sidonie : DBtoWebObserversKawa : work : after fetching or reading file")
			      (string-length wds-data-str)))
	  
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
		 (display-nl  "Sidonie : DBtoWebObserversKawa : work : creating regex.")
		 (regex "^[a-zA-Z]")))

	  (tst-space-string
	   (lambda (s)
	     (if (regex-match rgx s)
		 s
		 '())))

	  (wds-data-str-no-spaces 
	   (begin
	     (display-nl  "Sidonie : DBtoWebObserversKawa : work : running  map-nil-iter-optim-tail-calls-call....")
	     ( map-nil-iter-optim-tail-calls-call tst-space-string wds-data-str-split )))

	  ;; get the observers codes only
	  (wds-data-obs-codes (map car
				   (map (lambda (s)
					  (regex-split " " s))
					wds-data-str-no-spaces)))

	  ;; crash:
	  ;;(wds-data-obs-codes-rm-dup (remove-duplicates wds-data-obs-codes))
	  (wds-data-obs-codes-rm-dup (uniq wds-data-obs-codes))

	  ;; like 'uniq' UNIX command 
	  ;;(wds-data-obs-codes-uniq (remove-duplicates-sorted wds-data-obs-codes))

	  ;; variables used for creating HTML page using html/xml literals

	  (html-literal-table-row '()) ;; table row for a code and observer
	  (html-literal-table-data-observer '()) ;; table data : observer
	  (html-literal-table-data-code '()) ;; table data : code
	  (literal-rows-list '()) ;; list of the litterals rows 
	  (html-literal-table '()) ;; table of observers
	  (html-literal '()) ;; the whole set of HTML literals
	  (html-literal-str "") ;; the string of the whole set of HTML literals
	  (option-lst '(DIR: "LTR" BORDER: 1 width: 315 id: "table_observateurs")) ;; various options for various html tags (here TABLE)
	  (options-and-arguments-lst '()) 
	  #;(option-lst-lit '(DIR: "LTR" BORDER: 1 width: 315 id: "table_observateurs"))
	  (debug #f)
	  (result-code '()) ;; CODE result
	  (result-observer '()) ;; OBSERVER result
	  (len-codes-list (length wds-data-obs-codes)) ;; some stats on codes
	  (len-codes-uniq-list (length wds-data-obs-codes-rm-dup))
	  (fileName "ObservateursCodes.html") ;; file to write
	  (fileNameCodesEnglishAlphabName "ObserversCodes.html")
	  (fileNameCodesAlphabCodes "ObservateursCodesAlphab.html")
	  
	  ;; something like: /var/lib/tomcat8/webapps/Sidonie/ObservateursCodesAlphab.html
	  (fullPathFileName (string-append WebAppsDir
					   fs
					   appName
					   fs
					   fileName))

	  (fullPathFileNameCodesEnglishAlphabName (string-append WebAppsDir
								 fs
								 appName
								 fs
								 fileNameCodesEnglishAlphabName))
	  (fullPathFileNameCodesAlphabCodes (string-append WebAppsDir
								 fs
								 appName
								 fs
								 fileNameCodesAlphabCodes))

	  (obs-code-lst '()) ;; observateur - code list
	  (res-alpha-codes "") ;; warning: res is global and typed but res-alpha-codes not ! 
	  (res-alpha-names-english "")
	  (sorted-obs-code-lst '()) ;; sorted observateur - code list
	  (debug-mode #t)
	  ) ;; end of LET

     
     ;;(set! debug-mode #t)
     ;; debug display
     (display-var-nl "Sidonie : DBtoWebObserversKawa : work :: debug-mode = " debug-mode)


     (display-nl  "Sidonie : DBtoWebObserversKawa : work : after let* declarations.")
     ;;(debug-display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : str1 = " str1)
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : length wds-data-str = " len-wds-data-str)
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (car wds-data-str-split) = " (car wds-data-str-split))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (cadr wds-data-str-split) = " (cadr wds-data-str-split))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (substring wds-data-str-minus-1 0 50) = " (substring wds-data-str-minus-1 0 50))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (substring wds-data-str-minus-2 0 50) = " (substring wds-data-str-minus-2 0 50))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (substring wds-data-str-equals 0 50) = " (substring wds-data-str-equals 0 50))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (cadr wds-data-str-split) = " (cadr wds-data-str-split))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (car wds-data-str-no-spaces) = " (car wds-data-str-no-spaces))
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : (car wds-data-obs-codes) = " (car wds-data-obs-codes))
     
     ;;(debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : option-lst = " option-lst)

     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work :  len-codes-list  = " len-codes-list )
     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work :  len-codes-uniq-list  = " len-codes-uniq-list )
     
     ;; partie HTML
     
     ;; HTML header and more

     (set! res-alpha-names-english
	   (gnu.lists.FString:toString
	    (string-append
	     "<HTML DIR=LTR>"
	     "      <HEAD>"
	     "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
	     "               <TITLE>Observers - Codes</TITLE>"
	     "    </HEAD>"
	     "    <body bgcolor=\"#FFFFC0\">"
	     "          <p align=center><b><font color=\"#000080\"><i>Observers' used codes: name alphabetical classification</i></font></b>"
	     "          <p>&nbsp;"
	     "          <TABLE align=center border=\"0\" width=\"80%\">"
	     "                 <TR>"
	     "                     <TD valign=left><a href=\"SidonieUnderstanding.htm#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
	     "                          <font size=\"2\"><em>Understand...</em></font>"
	     "                     </TD>"
	     "                 </TR>")))


     (set! res-alpha-codes 
	   (gnu.lists.FString:toString
	    (string-append
	     "<HTML DIR=LTR>"
	     "      <HEAD>"
	     "            <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">"
	     
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
	      
     (set! res
	   (gnu.lists.FString:toString
	    (string-append
	     "<HTML DIR=LTR>"
	     "      <HEAD>"
	     #;"               <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=Windows-1252\">"
	     "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
	     "               <TITLE>Observateurs - Codes</TITLE>"
	     "    </HEAD>"
	     "    <body bgcolor=\"#FFFFC0\">"
	     "          <p align=center><b><font color=\"#000080\"><i>Codes utilisés pour les Observateurs : classement par ordre alphabétique des noms</i></font></b>"
	     "          <p>&nbsp;"
	     "          <TABLE align=center border=\"0\" width=\"80%\">"
	     "                 <TR>"
	     "                     <TD valign=left><a href=\"SidonieDescriptionF.html#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
	     "                          <font size=\"2\"><em>Tout savoir...</em></font>"
	     "                     </TD>"
	     "                 </TR>"
	     "                 <TR>"
	     "                     <TD valign=left><a href=\"ObservateursCodesAlphab.html\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
	     "                         <font size=\"2\"><em>Classement par codes</em></font>"
	     "                     </TD>"
	     "                 </TR>")))
	  
	
     
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : res = " res))

     
     ;; converting from SQL server to MySQL (MariaDB)
     (set! marequete (sql-server->mysql-server-syntax marequete))

     (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : Voila la valeur SQL de la requète : marequete = " marequete)
     
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
		       
		  ;;(append-string-to-result "<tr>")
		       
		  ;; 0 : code
		  (set! result-code (rs:getString 1))
		  
		  (if (or (rs:wasNull) (string-null? result-code))

		      (debug-display-nl  "Sidonie : DBtoWebObserversKawa : work : result (code) : string or result set is null")
		       
		      (else-block

			;;(append-string-to-result "<td>")
			(set! html-literal-table-data-code
			      #;(html:td DIR: "LTR" ALIGN: "LEFT" result)
			      #<td DIR="LTR" ALIGN="LEFT">&[result-code]</>)
			      ;;#<td DIR=LTR ALIGN=LEFT>&[result-code]</>)

			(if debug
			    (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : result (code) = " result-code))
			;;(append-string-to-result (string-upcase result))
			#;(append-string-to-result "</td>")
			 
			 
			;; 1 : auteur (Observer)
			(set! result-observer (rs:getString 2))
			
			(if (rs:wasNull)
			    (set! result-observer "NuLL"))
			
			(if (not (member result-code wds-data-obs-codes-rm-dup)) ;; not in the "Washington list"
			    
			    (then-block
			     (debug-display-nl  "Sidonie : DBtoWebObserversKawa : work : result (code) : not in the Washington list")
			     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : result-code = " result-code)
			     (debug-only display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : result-observer = " result-observer))

			    (else-block
			     ;;(append-string-to-result "<td>")
			     
			     (set! html-literal-table-data-observer 
				   #;(html:td DIR: "LTR" ALIGN: "LEFT" result)
				   #<td DIR="LTR" ALIGN="LEFT">&[result-observer]</>)
			 
			     (if debug
				 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : result (Observer) = " result-observer))
			
			     ;;(append-string-to-result result)
			     ;;(append-string-to-result "</td>")
			 
			     (set! html-literal-table-row
				   (html:tr
				    html-literal-table-data-code
				    html-literal-table-data-observer))
			 
			     (if debug
				 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : html-literal-table-row = " html-literal-table-row))
			 
			     (set! literal-rows-list
				   (cons html-literal-table-row literal-rows-list))

			     ;; update the observer code list
			     (set! obs-code-lst
				   (cons
				    (cons result-observer result-code)
				    obs-code-lst))
			
			     (set! total (+ total 1))))))
		  
		  (rs:next) 
		  
		  ) ;; end WHILE (Do While ... Loop) 
	   
	   ) ;; end when (test empty SQL result set)


     (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : total = " total)
     
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work :literal-rows-list  = " literal-rows-list))

     (set! literal-rows-list
	   (reverse literal-rows-list)) ;; revert the list so it's well ordered to display
     
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work :(reverse literal-rows-list)   = " literal-rows-list))
     
     (set! options-and-arguments-lst
	   (append option-lst literal-rows-list))
     
     (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : debug = " debug)

     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : options-and-arguments-lst = " options-and-arguments-lst))

     ;; HTML table with options
     ;; Kawa offers simple slicing: @ not in Scheme R7RS 
     (set! html-literal-table
	   (apply html:table options-and-arguments-lst)) ;; OK
	   ;;(apply html:table literal-rows-list)) ;; OK
	   ;;(html:table literal-rows-list)) ;; OK but non-sense
	   ;;(html:table @literal-rows-list)) ;; KO
	   ;;(html:table option-lst literal-rows-list)) ;; OK but non-sense
	   ;;(html:table @option-lst @literal-rows-list)) ;; KO
	   ;;#<table DIR="LTR" BORDER="1" width="312" id="table_observateurs">&[@literal-rows-list]</>) ;; KO
	   ;;#<table DIR="LTR" BORDER="1" width="312" id="table_observateurs">@&[literal-rows-list]</>) ;; OK
	   ;;#<table DIR="LTR" BORDER="1" width="312" id="table_observateurs">POPUP</>) ;; OK
	   ;;#<table>POP UP</>) ;; OK
	   ;;(html:table "POP UP")) ;; OK

     ;;(set! html-literal-str (html-literal-table:toString))

     ;; HTML
     (set! html-literal
     	   #<td align="center">&[html-literal-table]</>)

     
     (set! html-literal-str (html-literal:toString))
      
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : html-literal-str = " html-literal-str))
     
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : res = " res))
     

     ;; adding the observers codes and names 

     (append-string-to-result html-literal-str)

     (append-string-to-result! 
      res-alpha-names-english
      html-literal-str)
     

     ;; HTML footer

     ;; we are in jersey/ path of the URL

     (display-nl  "Sidonie : DBtoWebObserversKawa : work : result : entering HTML footer writing...") 

     (append-string-to-result! 
      res-alpha-names-english
      (string-append
       "                  <TD valign=bottom><a href=\"SidonieUnderstanding.htm#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
       "                          <font size=\"2\"><em>Understand...</em></font></TD>"
       "          </TABLE>"
       "      </BODY>"
       "</HTML>"))

     (write-HTML-file-str fullPathFileNameCodesEnglishAlphabName res-alpha-names-english)

     (append-string-to-result
      (string-append
       "                  <TD valign=bottom><a href=\"SidonieDescriptionF.html#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
       "                          <font size=\"2\"><em>Tout savoir...</em></font></TD>"
       ;; unclosed table (verifier version anglaise)
       ;;"          </TR>"
       "          </TABLE>"
       "      </BODY>"
       "</HTML>"))

     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : res = " res))

     (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : debug = " debug)

     (display-msg-symb-nl  "Sidonie : DBtoWebObserversKawa : work :" fullPathFileName)

     (display-nl "Sidonie : DBtoWebObserversKawa : work : writing file...")

     ;; write file
     (write-HTML-file fullPathFileName)
     
     (display-nl "Sidonie : DBtoWebObserversKawa : work : after write-HTML-file")







     ;; write ordered codes

     ;; sort by codes the list of pairs (obs . codes)
     (set! sorted-obs-code-lst
	   (sort obs-code-lst string<? cdr))

     ;; create the list:
     ;;
     ;;             <TR>
     ;; 	      <TD DIR=LTR ALIGN=LEFT>A</TD>
     ;; 	      <TD DIR=LTR ALIGN=LEFT>Aitken R. G.</TD>
     ;; 	    </TR>
     ;; 	    <TR>
     ;; 	      <TD DIR=LTR ALIGN=LEFT>ABD</TD>
     ;; 	      <TD DIR=LTR ALIGN=LEFT>Abad A.</TD>
     ;; 	    </TR>
     ;; ...
     (set! literal-rows-list
	   (map (lambda (obs-code)
		  (html:tr
		   #<td DIR="LTR" ALIGN="LEFT">&[(cdr obs-code)]</>
		   #<td DIR="LTR" ALIGN="LEFT">&[(car obs-code)]</>))
		sorted-obs-code-lst))

     (set! options-and-arguments-lst
	   (append option-lst literal-rows-list))

     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : options-and-arguments-lst = " options-and-arguments-lst))

     (set! html-literal-table
	   (apply html:table options-and-arguments-lst))

     ;; HTML
     (set! html-literal
     	   #<td align="center">&[html-literal-table]</>)

     
     (set! html-literal-str (html-literal:toString))
      
     (if debug
	 (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : html-literal-str = " html-literal-str))

     ;; adding the observers codes and names for alphabetical codes

     (append-string-to-result! 
      res-alpha-codes
      html-literal-str)


     (append-string-to-result! 
      res-alpha-codes
      (string-append
       "                  <TD valign=bottom><a href=\"SidonieDescriptionF.html#codes\"><img src=\"retour_blanc.gif\" width=\"26\" height=\"26\" border=0></a>"
       "                          <font size=\"2\"><em>Tout savoir...</em></font></TD>"
       "          </TABLE>"
       "      </BODY>"
       "</HTML>"))
     

     ;; write file for alphabetical codes
     (write-HTML-file-str fullPathFileNameCodesAlphabCodes res-alpha-codes)
     
     ) ;; end let*
   
  

   (eu.oca.DataBase:closeStatic)
   (display "Sidonie : DBtoWebObserversKawa : work : eu.oca.DataBase:closeStatic PASSED")
   (newline)
   
   ;; (eu.oca.DataBase:deregisterDriverStatic)
   ;; (display "Sidonie : DBtoWebObserversKawa : work : eu.oca.DataBase:deregisterDriverStatic PASSED")
   ;; (newline)
   
   ;; (display-msg-var-nl  "Sidonie : DBtoWebObserversKawa : work : res = " res)
   
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
   (debug-display-nl "Sidonie : DBtoWebObserversKawa.scm :: entering fix")
   (let ((r (inexact->exact (truncate x))))
     (debug-display "Sidonie : DBtoWebObserversKawa.scm :: fix :: r =")
     (debug-display r)
     (newline)
    r))


  ;; fn: file name
  ((write-HTML-file fn)
   (define op (open-output-file fn))
   ;;(write res op)
   (display-nl (string-append
		"Sidonie : DBtoWebObserversKawa : write-HTML-file : writing file "
		fn
		"..."))
   (write-string res op)
   (newline op)
   (close-output-port op)
   (display-nl "Sidonie : DBtoWebObserversKawa : write-HTML-file : file written.")
   )

  ((write-HTML-file-str fn str)
   (define op (open-output-file fn))
   (display-nl (string-append
		"Sidonie : DBtoWebObserversKawa : write-HTML-file-str : writing file "
		fn
		"..."))
   (write-string str op)
   (newline op)
   (close-output-port op)
   (display-nl "Sidonie : DBtoWebObserversKawa : write-HTML-file-str : file written.") )

  ) ;; end of class










