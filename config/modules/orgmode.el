(setq org-startup-with-inline-images t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((js . t)))

(add-hook 'org-mode-hook (lambda () (setq truncate-lines t)))

(defun my/org-export-to-pdf ()
  (interactive)
  (let ((pdf-file (org-latex-export-to-pdf)))
    (when (and pdf-file (file-exists-p pdf-file))
      (start-process "open-pdf" nil "zathura" pdf-file))))
(define-key org-mode-map (kbd "C-E") 'my/org-export-to-pdf)

(defun my/insert-wrapfigure ()
  (interactive)
  (insert
   "#+BEGIN_LaTeX\n"
   "\\begin{wrapfigure}{r}{0.4\\textwidth}\n"
   "  \\includegraphics[width=0.4\\textwidth]{/home/puppy/Pictures/nix_emacs_logo_small.png}\n"
   "\\end{wrapfigure}\n"
   "#+END_LaTeX\n"))

(defun my/insert-example-document ()
  (interactive)
  (insert
   "#+TITLE: Title\n"
   "#+AUTHOR: Author\n"
   "#+DESCRIPTION: Description\n"
   "* Chapters\n"
   "** Chapter 1\n"
   "*** Subchapter 1\n"))

(defun my/insert-figure-block ()
  (interactive)
  (insert "#+CAPTION: \n#+NAME: \n[[file:]]")
  (backward-char 2))

(defun my/insert-code-block ()
  (interactive)
  (insert "#+BEGIN_SRC language\n\n#+END_SRC\n")
  (previous-line)
  (previous-line))

(defun my/insert-table-skeleton ()
  (interactive)
  (insert "\\begin{tabular}{|c|c|}\n\\hline\n & \\\\\n\\hline\n & \\\\\n\\hline\n\\end{tabular}"))
