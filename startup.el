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

;; Use F9 to toggle line numbers
(global-set-key (kbd "<f9>") 'global-display-line-numbers-mode)

;; Toggle visual line mode and org-indent when in org mode
;; found here: https://emacs.stackexchange.com/posts/22180/revisions
;; `with-eval-after-load' macro was introduced in Emacs 24.x
;; In older Emacsen, you can do the same thing with `eval-after-load'
;; and '(progn ..) form.
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;; Config for a Scheme REPL for SICP
(setq geiser-mit-binary "/usr/local/bin/scheme")
(setq geiser-active-implementations '(mit))
