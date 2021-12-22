;; -*- lexical-binding: t; -*-

;; Use cons cell(car)
;; Set 'Effect.Ref to cdr just for debugging.

(require 'Data.Unit)

(defvar Effect.Ref.new
  (lambda (val)
    (lambda ()
      (cons val 'Effect.Ref))))

(defvar Effect.Ref.newWithSelf
  (lambda (f)
    (lambda ()
      (let ((ref (cons nil 'Effect.Ref)))
        (setcar ref (funcall f ref))
        ref))))

(defvar Effect.Ref.read
  (lambda (ref)
    (lambda ()
      (car ref))))

(defvar Effect.Ref.modifyImpl
  (lambda (f)
    (lambda (ref)
      (lambda ()
        (let ((obj (funcall f (car ref))))
          (setcar ref (psel/alist-get 'state obj))
          (psel/alist-get 'value obj))))))

(defvar Effect.Ref.write
  (lambda (val)
    (lambda (ref)
      (lambda ()
        (setcar ref val)
        Data.Unit.unit))))
