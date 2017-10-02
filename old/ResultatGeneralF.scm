;; compilation method:

;; java -jar ~/Dropbox/kawa-2.1-jdk8.jar -C ResultatGeneralF.scm
;; (java -jar /usr/local/share/java/kawa-2.1.jar -C ResultatGeneralF.scm)
;; other method to compile: kawa -C ResultatGeneralF.scm 
;; jar cf KawaFunctProg.jar eu



(module-name "eu.oca.kawafunct.ResultatGeneralF")

(require 'regex)

(define-simple-class ResultatGeneralF ()

  (CocherNom ::java.lang.String init-keyword: CocherNom:)
  (Nom ::java.lang.String init-keyword: Nom:)
  (CocherHip ::java.lang.String init-keyword: CocherHip:)
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

  (dataDir ::java.lang.String init-keyword: dataDir:)
  (htmlCounterPage ::java.lang.String init-keyword: htmlCounterPage:)
  (counterPathFileName ::gnu.lists.FString init-keyword: counterPathFileName:)
  ;;(counterPathFileName ::java.lang.String init-keyword: counterPathFileName:)

  ;; ;; Alternative type-specification syntax.
  ;; (y type: double init-keyword: y:)
  ;; (zero-2d :: ResultatGeneralF allocation: 'static
  ;;  init-value: (ResultatGeneralF 0))
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

	   #;(htmlPage ::java.lang.String)) ;; htmlPage : page to display
   
   (set! CocherNom cochernomParam)
   (set! Nom nomParam)
   (set! CocherHip cocherhipParam)
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

   ;;(set! htmlCounterPage htmlPage)

   (work))

  ;; ((*init* (xy0 ::double))
  ;;  ;; Call above 2-argument constructor.
  ;;  (invoke-special ResultatGeneralF (this) '*init* xy0 xy0))

  ;; Need a default constructor as well.
  ((*init*) #!void)

  ;; ((add (other ::ResultatGeneralF)) ::ResultatGeneralF
  ;;  ;; Kawa compiles this using primitive Java types!
  ;;  (ResultatGeneralF
  ;;    x: (+ x other:x)
  ;;    y: (+ y other:y)))
  ;; ((scale (factor ::double)) ::ResultatGeneralF
  ;;  (ResultatGeneralF x: (* factor x) y: (* factor y)))
  
  ;; ((norm) ::double
  ;;  7.0 )

  ;; ((plus L) ::int
  ;;  (+ (car L) (cadr L)))

  ;; ((carre L) ::gnu.lists.LList
  ;;  (map (lambda (x) (* x x )) L))

  ((getDataDir) ::java.lang.String
   dataDir)

  ((pwd) ::java.lang.String 
   (gnu.kawa.io.FilePath:toString  (current-path)))

  ((computeTemplateDir) ::java.lang.String 
   (gnu.kawa.io.FilePath:toString  (current-path)))

  ((getCounterPathFileName) ::java.lang.String 
   (gnu.lists.FString:toString counterPathFileName))
   ;;" be bop a lulaa")

  ((setCounterPathFileName (cpf ::gnu.lists.FString)) ;; setter method
   (set! counterPathFileName cpf))

  ((existTemplate?) ::int 
   ;;(file-exist? 
   0)

  ((existCounterFileTxt?) ::java.lang.String
   (if (file-exists? (getCounterPathFileName))
       "YES"
       "NO"))

  ((existHtmlPageTxt?) ::java.lang.String
   (if (file-exists? htmlCounterPage)
       "YES"
       "NO"))

  ((work) ::int ;; do the job: count,display web page 
   ;;(eu.oca.DataBase:searchDriverStatic)
   (eu.oca.DataBase:helloStatic)
   ;;(setCounterPathFileName (computeCounterPathFileName dataDir)) ;; compute and set the counter filename
   ;;(define response (path-data htmlCounterPage))
   0)

  ((getHtmlCounterPage) ::java.lang.String
   (display "in (getHtmlCounterPage)")
   (newline)
   (display htmlCounterPage)
   (newline)
   (define dir "/Users/mattei")
   (define HCP &<{&[htmlCounterPage]})
   ;;(define toStrHCP (->string HCP))
   ;; (display "------------------------------------")
   ;; (newline)
   ;; (write toStrHCP)
   ;; (newline)
   ;; (display "------------------------------------")
   ;; (newline)
   ;; (display toStrHCP)
   ;; (newline)
   ;; (display "------------------------------------")
   (newline)
   (display "string replacement:")
   (newline)
   (define cpt (update-counter))
   (define response (insert-counter-in-html-page HCP cpt));;toStrHCP 7))
   (display response)
   (display "------------------------------------")
   (newline)
   ;;(gnu.lists.FString:toString (read-string 65535 (open-input-file htmlCounterPage)))
   ;;(gnu.lists.Blob:toString (path-data htmlCounterPage)))
   response)

  ((update-counter)
   (display "in update-counter")
   (newline)
   (let ((cv 1)
	 (fn (getCounterPathFileName)))
     (if (file-exists? fn)
	 (begin
	   (set! cv (read-counter-value fn))
	   (delete-file fn)
	   (write-counter-value fn (+ 1 cv)))
       (begin
	 (display "------------------------------------")
	 (newline)
	 (display "Warning : no counter file !!!")
	 (newline)))
   cv))

  
  ((blabla) ::java.lang.String ;;gnu.lists.FString
   (begin 
     (fct 2)
     "be bop a lula"))
  
  ((pwd) ::java.lang.String 
   (gnu.kawa.io.FilePath:toString  (current-path)))
  
)


(define counterFileName "counter.txt")

(define (computeCounterPathFileName dataDir)
 (string-append  dataDir "/counter.txt"))

(define (fct x)
    (+ x 3))

(define (insert-counter-in-html-page str n)
  (regex-replace "ShowDigits" str n))

(define (read-counter-value fn)
   (define cf &<{&[fn]})
   ;; (define toStringCF (gnu.lists.Blob:toString (->string cf)))
   ;; (display "------------------------------------")
   ;; (newline)
   ;; (display "counter value string:")
   ;; (display  toStringCF)
   ;; (display "|")
   ;; (newline)
   ;; ;;(define toIntegerCF (->int cf))
   ;; (if (string? toStringCF)
   ;;     (display "toStringCF is a string !")
   ;;     (display "toStringCF is NOT a string !"))
   ;; (newline)
   (define toFStringCF cf);(gnu.lists.FString toStringCF))
   (display "------------------------------------")
   (newline)
   (display "last char string:")
   (define lastCS  (string-ref toFStringCF (- (string-length  toFStringCF) 1)))
   (display (char->integer lastCS))
   (display "|")
   (newline)
  
   ;; (string-set! toFStringCF (- (string-length  toFStringCF) 1) #\space) ;; replace the trailing CR by a space
   ;; (display "counter value Fstring:")
   ;; (display  toFStringCF)
   ;; (display "|")
   ;; (newline)
   (define strCount (regex-split (string lastCS) toFStringCF))
   (display "counter value strCount:")
   (display  strCount)
   (display "|")
   (newline)
   (define rv (string->number (car strCount)))
   (display "------------------------------------")
   (newline)
   (display "counter value:")
   (newline)
   (display rv)
   (newline)
   rv)


(define (write-counter-value fn val)
  (define op (open-output-file fn))
  (write val op)
  (newline op)
  (close-output-port op))
