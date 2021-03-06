
;; java -jar /usr/local/share/java/kawa-2.1.jar -C Vector2D.scm
;; jar cf scheme.jar eu

(module-name "eu.oca.kawafunct.Vector2D")

(define-simple-class Vector2D ()
  (x ::double init-keyword: x:)
  ;; Alternative type-specification syntax.
  (y type: double init-keyword: y:)
  (zero-2d :: Vector2D allocation: 'static
   init-value: (Vector2D 0))
  ;; An object initializer (constructor) method.
  ((*init* (x0 ::double) (y0 ::double))
   (set! x x0)
   (set! y y0))
  ((*init* (xy0 ::double))
   ;; Call above 2-argument constructor.
   (invoke-special Vector2D (this) '*init* xy0 xy0))
  ;; Need a default constructor as well.
  ((*init*) #!void)
  ((add (other ::Vector2D)) ::Vector2D
   ;; Kawa compiles this using primitive Java types!
   (Vector2D
     x: (+ x other:x)
     y: (+ y other:y)))
  ((scale (factor ::double)) ::Vector2D
   (Vector2D x: (* factor x) y: (* factor y)))
  
  ((norm) ::double
   7.0 )

  ((plus L) ::int
   (+ (car L) (cadr L)))

  ((carre L) ::gnu.lists.LList
   (map (lambda (x) (* x x )) L))

  ((blabla) ::java.lang.String ;;gnu.lists.FString
   "be bop a lula")
  
  )
