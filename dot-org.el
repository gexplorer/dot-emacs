(use-package org
  :ensure
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c a"    . org-agenda)
	 ("C-c c"    . org-capture)
         ("C-S-n"    . org-move-subtree-down)
         ("C-S-p"    . org-move-subtree-up))
  :commands (org-map-entries org-archive-subtree org-element-property org-element-at-point)
  :custom
  (org-priority-faces `((65 . ,(face-foreground 'error))
                        (66 . ,(face-foreground 'warning))))
  (org-adapt-indentation nil)
  (org-agenda-compact-blocks nil)
  (org-agenda-custom-commands
   '(("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (todo "NEXT|WAITING"
             ((org-agenda-overriding-header "Next:"))))
      nil)))
  (org-agenda-files '("~/Dropbox/org/" "~/Dropbox/org/work/"))
  (org-agenda-persistent-filter t)
  (org-agenda-scheduled-leaders '("Scheduled: " "Sched.%2dx: "))
  (org-agenda-show-future-repeats nil)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-todo-ignore-with-date t)
  (org-babel-load-languages '((emacs-lisp . t) (shell . t) (sql . t)))
  (org-blank-before-new-entry '((heading . auto) (plain-list-item . auto)))
  (org-capture-templates
   '(("w" "Work" entry
      (file "~/Dropbox/org/Work/Work.org")
      "")))
  (org-catch-invisible-edits 'smart)
  (org-cycle-level-faces nil)
  (org-cycle-separator-lines 2)
  (org-deadline-warning-days 3)
  (org-directory "~/Dropbox/org")
  (org-ellipsis "…")
  (org-fontify-done-headline t)
  (org-hide-block-startup nil)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-highlight-links '(bracket angle plain radio tag date footnote))
  (org-image-actual-width t)
  (org-insert-heading-respect-content t)
  (org-log-done-with-time nil)
  (org-log-note-headings
   '((done . "CLOSING NOTE %t")
     (state . "")
     (note . "Note taken on %t")
     (reschedule . "Rescheduled from %S on %t")
     (delschedule . "Not scheduled, was %S on %t")
     (redeadline . "New deadline from %S on %t")
     (deldeadline . "Removed deadline, was %S on %t")
     (refile . "Refiled on %t")
     (clock-out . "")))
  (org-log-repeat 'time)
  (org-modules '(org-bbdb org-docview org-info org-w3m))
  (org-pretty-entities nil)
  (org-refile-targets '((org-agenda-files :level . 1)))
  (org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/")
  (org-special-ctrl-a/e t)
  (org-special-ctrl-k t)
  (org-startup-folded nil)
  (org-startup-with-inline-images t)
  (org-tags-column 0)
  (org-todo-keyword-faces '(("NEXT" . "#2aa198") ("WAIT" . "#268bd2")))
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "DONE(d)")))
  (org-use-fast-todo-selection t)
  :custom-face
  (org-agenda-date ((t (:inherit variable-pitch :weight bold :foreground nil :height 125))))
  (org-agenda-date-today ((t (:inverse-video nil))))
  (org-agenda-date-weekend ((t (:foreground nil :underline t))))
  (org-agenda-structure ((t (:inherit variable-pitch))))
  (org-block ((t (:inherit (highlight fixed-pitch)))))
  (org-block-begin-line ((t (:inherit (highlight fixed-pitch)))))
  (org-block-end-line ((t (:inherit (highlight fixed-pitch)))))
  (org-date ((t (:inherit fixed-pitch :underline nil))))
  (org-document-info-keyword ((t (:inherit (org-meta-line fixed-pitch)))))
  (org-done ((t (:foreground nil :strike-through t :inherit (shadow fixed-pitch)))))
  (org-document-title ((t (:height 1.0))))
  (org-headline-done ((t (:foreground nil))))
  (org-hide ((t (:inherit fixed-pitch))))
  (org-meta-line ((t (:inherit fixed-pitch))))
  (org-level-1 ((t (:foreground nil :height 1.0))))
  (org-level-2 ((t (:foreground nil :height 1.0))))
  (org-level-3 ((t (:foreground nil :height 1.0))))
  (org-level-4 ((t (:foreground nil :height 1.0))))
  (org-level-5 ((t (:foreground nil :height 1.0))))
  (org-level-6 ((t (:foreground nil :height 1.0))))
  (org-level-7 ((t (:foreground nil :height 1.0))))
  (org-level-8 ((t (:foreground nil :height 1.0))))
  (org-priority ((t (:inherit fixed-pitch :weight bold))))
  (org-property-value ((t (:inherit fixed-pitch))))
  (org-scheduled ((t (:foreground nil))))
  (org-scheduled-previously ((t (:foreground ,(face-foreground 'shadow)))))
  (org-scheduled-today ((t (:foreground ,(face-foreground 'match)))))
  (org-special-keyword ((t (:inherit fixed-pitch))))
  (org-table ((t (:inherit fixed-pitch))))
  (org-tag ((t (:inherit fixed-pitch))))
  (org-todo ((t (:inherit fixed-pitch :foreground nil :weight bold))))
  (org-verbatim ((t (:inherit (shadow fixed-pitch highlight)))))
  :config
  (defun org-archive-done-tasks()
    "Archive done tasks."
    (interactive)
    (org-map-entries
     (lambda ()
       (org-archive-subtree)
       (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
     "/DONE" 'file)))

(use-package org-indent
  :delight
  :disabled
  :hook (org-mode . org-indent-mode)
  :custom
  (org-indent-)
  )

(use-package org-bullets
  :ensure
  :disabled
  :delight
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "○" "○" "○" "○" "○" "○" "○")))

(use-package org-superstar
  :ensure
  :disabled
  :delight
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-cycle-headline-bullets nil)
  (org-superstar-headline-bullets-list (quote ("●" "◉" "◎" "○")))
  (org-superstar-item-bullet-alist (quote ((42 . 9671) (43 . 9657) (45 . 9643))))
  (org-superstar-special-todo-items t)
  (org-superstar-todo-bullet-alist
   (quote
    (("TODO" . 9744)
     ("NEXT" . 9635)
     ("WAIT" . 9640)
     ("DONE" . 9632)))))

(use-package htmlize
  :ensure
  :after org-mode)

(use-package ox-reveal
  :ensure
  :after org-mode
  :custom
  (org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/"))
