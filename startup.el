;; Transparency

;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; redo keychords for a german keyboard

(global-set-key (kbd "C-M-ß") 'indent-region)

;; no bling
;; from:
;; https://alexschroeder.ch/wiki/2020-08-26_Emacs_without_the_bling

;; deactivate some bling
(dolist (mode '(tool-bar-mode
		blink-cursor-mode
		menu-bar-mode
		scroll-bar-mode))
  (when (fboundp mode)
    (funcall mode -1)))

;; center mode
;; also from here:
;; https://alexschroeder.ch/wiki/2020-08-26_Emacs_without_the_bling

;; center the window by adding a very wide fringe
(define-minor-mode center-window-mode
  "Minor mode to center the window using wide fringes."
  :init-value nil
  :global t
  :group 'editing-basics
  (if (not center-window-mode)
      (set-fringe-style nil);; default
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* (+ fill-column 4)
	      (frame-char-width)))
        2))))

(center-window-mode 1)

;; Use F9 to toggle centering
(global-set-key (kbd "<f9>") 'center-window-mode)
