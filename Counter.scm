
;; java -jar /usr/local/share/java/kawa-2.1.jar -C Counter.scm
;; jar cf KawaFunctProg.jar eu



(module-name "eu.oca.kawafunct.Counter")

(require 'regex)

(include-relative  "../git/LOGIKI/lib/display.scm")
(include-relative  "../git/LOGIKI/lib/debug.scm") ;; for debug

(define-simple-class Counter ()

  ;; (x ::double init-keyword: x:)
  (dataDir ::java.lang.String init-keyword: dataDir:)
  (htmlCounterPage ::java.lang.String init-keyword: htmlCounterPage:)
  (counterPathFileName ::gnu.lists.FString init-keyword: counterPathFileName:)
  ;;(counterPathFileName ::java.lang.String init-keyword: counterPathFileName:)
  (debug-mode :: java.lang.Boolean init-keyword: debug-mode:)


  ;; ;; Alternative type-specification syntax.
  ;; (y type: double init-keyword: y:)
  ;; (zero-2d :: KawaCode allocation: 'static
  ;;  init-value: (KawaCode 0))
  ;; ;; An object initializer (constructor) method.
  ;; ((*init* (x0 ::double) (y0 ::double))
  ;;  (set! x x0)
  ;;  (set! y y0))
  ((*init* (pc ::java.lang.String)) ;; pc : path to counter
   (set! dataDir pc))

  ((*init* (pc ::java.lang.String) (htmlPage ::java.lang.String)) ;; pc : path to counter, htmlPage : page to display
   (set! dataDir pc)
   (set! htmlCounterPage htmlPage)
   (set! debug-mode #f)
   (work))

  ;; ((*init* (xy0 ::double))
  ;;  ;; Call above 2-argument constructor.
  ;;  (invoke-special Counter (this) '*init* xy0 xy0))

  ;; Need a default constructor as well.
  ((*init*) #!void)

  ;; ((add (other ::Counter)) ::Counter
  ;;  ;; Kawa compiles this using primitive Java types!
  ;;  (Counter
  ;;    x: (+ x other:x)
  ;;    y: (+ y other:y)))
  ;; ((scale (factor ::double)) ::Counter
  ;;  (Counter x: (* factor x) y: (* factor y)))
  
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
   (setCounterPathFileName (computeCounterPathFileName dataDir)) ;; compute and set the counter filename
   ;;(define response (path-data htmlCounterPage))
   0)






  ((getHtmlCounterPage) ::java.lang.String
   (display "Sidonie : Counter : getHtmlCounterPage")
   (newline)

   ;; debug display
   (display-var-nl "Sidonie :  Counter : getHtmlCounterPage :: debug-mode = " debug-mode)

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
   (display "Sidonie : Counter : string replacement:")
   (newline)
   (define cpt (update-counter))
   (define response (insert-counter-in-html-page HCP cpt));;toStrHCP 7))
   (debug-display response)
   (debug-display "------------------------------------")
   (debug-newline)
   ;;(gnu.lists.FString:toString (read-string 65535 (open-input-file htmlCounterPage)))
   ;;(gnu.lists.Blob:toString (path-data htmlCounterPage)))
   response)






  ((update-counter)
   (display "Sidonie : Counter : update-counter")
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

  
  ((computeCounterPathFileName dataDir)
   (string-append  dataDir "/counter.txt"))

  ((insert-counter-in-html-page str n)
   (regex-replace "ShowDigits" str n))




  ((read-counter-value fn)
   ;; Warning: define only allowed in begining of block in Scheme
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
   (display "Sidonie : Counter : read-counter-value : last char string:")

   ;; last char of the string
   (define lastCS  (string-ref toFStringCF 
			       (- (string-length  toFStringCF) 1)))
   (display (char->integer lastCS))
   (display "|")
   (newline)
  
   ;; (string-set! toFStringCF (- (string-length  toFStringCF) 1) #\space) ;; replace the trailing CR by a space
   ;; (display "counter value Fstring:")
   ;; (display  toFStringCF)
   ;; (display "|")
   ;; (newline)
   (define strCount (regex-split (string lastCS) toFStringCF))
   (display "Sidonie : Counter : read-counter-value : counter value strCount:")
   (display  strCount)
   (display "|")
   (newline)
   (define rv (string->number (car strCount)))
   (display "------------------------------------")
   (newline)
   (display "counter value:")
   (newline)
   (debug-display rv)
   (debug-newline)
   (display "Sidonie : Counter : read-counter-value : before rv")
   (newline)
   rv)




  ((write-counter-value fn val)
   (define op (open-output-file fn))
   (write val op)
   (newline op)
   (close-output-port op))


  ;; ((blabla) ::java.lang.String ;;gnu.lists.FString
  ;;  (begin 
  ;;    (fct 2)
  ;;    "be bop a lula"))
  
  ((pwd) ::java.lang.String 
   (gnu.kawa.io.FilePath:toString  (current-path)))
  
)


;; (define counterFileName "counter.txt")

;; (define (computeCounterPathFileName dataDir)
;;  (string-append  dataDir "/counter.txt"))

;; (define (fct x)
;;     (+ x 3))

;; (define (insert-counter-in-html-page str n)
;;   (regex-replace "ShowDigits" str n))

;; (define (read-counter-value fn)
;;    (define cf &<{&[fn]})
;;    ;; (define toStringCF (gnu.lists.Blob:toString (->string cf)))
;;    ;; (display "------------------------------------")
;;    ;; (newline)
;;    ;; (display "counter value string:")
;;    ;; (display  toStringCF)
;;    ;; (display "|")
;;    ;; (newline)
;;    ;; ;;(define toIntegerCF (->int cf))
;;    ;; (if (string? toStringCF)
;;    ;;     (display "toStringCF is a string !")
;;    ;;     (display "toStringCF is NOT a string !"))
;;    ;; (newline)
;;    (define toFStringCF cf);(gnu.lists.FString toStringCF))
;;    (display "------------------------------------")
;;    (newline)
;;    (display "last char string:")
;;    (define lastCS  (string-ref toFStringCF (- (string-length  toFStringCF) 1)))
;;    (display (char->integer lastCS))
;;    (display "|")
;;    (newline)
  
;;    ;; (string-set! toFStringCF (- (string-length  toFStringCF) 1) #\space) ;; replace the trailing CR by a space
;;    ;; (display "counter value Fstring:")
;;    ;; (display  toFStringCF)
;;    ;; (display "|")
;;    ;; (newline)
;;    (define strCount (regex-split (string lastCS) toFStringCF))
;;    (display "counter value strCount:")
;;    (display  strCount)
;;    (display "|")
;;    (newline)
;;    (define rv (string->number (car strCount)))
;;    (display "------------------------------------")
;;    (newline)
;;    (display "counter value:")
;;    (newline)
;;    (display rv)
;;    (newline)
;;    rv)


;; (define (write-counter-value fn val)
;;   (define op (open-output-file fn))
;;   (write val op)
;;   (newline op)
;;   (close-output-port op))
