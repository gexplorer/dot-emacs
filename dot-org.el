(use-package org
  :ensure t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c c"    . org-capture)
         ("C-S-n"    . org-move-subtree-down)
         ("C-S-p"    . org-move-subtree-up))
  :commands (org-map-entries org-archive-subtree org-element-property org-element-at-point)
  :custom
  (org-adapt-indentation nil)
  (org-M-RET-may-split-line nil)
  (org-startup-indented t)
  (org-startup-folded nil)
  (org-default-priority 68)
  (org-priority-faces `((65 . ,(face-foreground 'error))
                        (66 . ,(face-foreground 'warning))
                        (67 . ,(face-foreground 'font-lock-variable-name-face))))
  (org-deadline-past-days 0)
  (org-babel-load-languages '((emacs-lisp . t) (shell . t) (sql . t) (http . t)))
  (org-confirm-babel-evaluate nil)
  (org-capture-templates
   '(("i" "Inbox" entry
      (file "~/org/inbox.org")
      "")))
  (org-cycle-level-faces nil)
  (org-deadline-warning-days 0)
  (org-scheduled-past-days 0)
  (org-directory "~/org")
  (org-ellipsis "⏷")
  (org-hide-emphasis-markers nil)
  (org-hide-leading-stars t)
  (org-refile-targets '(
                        ;; (nil :level . 1)
                        ;; (org-agenda-files :level . 0)
                        (org-agenda-files :tag . "project")
                        (org-agenda-files :tag . "area")
                        ))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-special-ctrl-a/e t)
  (org-special-ctrl-k t)
  (org-fontify-done-headline t)
  (org-tags-column 90)
  (org-use-tag-inheritance nil)
  (org-auto-align-tags t)
  (org-todo-keyword-faces `(("WAIT" . ,(face-foreground 'font-lock-variable-name-face))
                            ("WAIT" . ,(face-foreground 'font-lock-variable-name-face))))
  (org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "DONE(d)")))
  (org-html-head "<link href=\"http://thomasf.github.io/solarized-css/solarized-light.min.css\" rel=\"stylesheet\"/>")
  :custom-face
  (org-level-1 ((t (:foreground nil))))
  (org-level-2 ((t (:foreground nil))))
  (org-level-3 ((t (:foreground nil))))
  (org-level-4 ((t (:foreground nil))))
  (org-level-5 ((t (:foreground nil))))
  (org-level-6 ((t (:foreground nil))))
  (org-level-7 ((t (:foreground nil))))
  (org-level-8 ((t (:foreground nil))))
  (org-done ((t (:foreground nil :inherit font-lock-comment-face :strike-through t))))
  (org-headline-done ((t (:foreground nil :inherit font-lock-comment-face :strike-through t))))
  (org-todo ((t (:inherit default :foreground nil))))
  (org-tag ((t (:inherit default :inherit font-lock-comment-face))))
  (org-ellipsis ((t (:inherit default))))
  (org-priority ((t (:inherit default :height 1.0))))
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
  :disabled
  :delight
  :hook (org-mode . org-indent-mode))

(use-package org-bullets
  :disabled
  :ensure
  :delight
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("•" "◦" "◦" "◦" "◦" "◦" "◦" "◦")))

(use-package org-super-agenda
  :ensure t
  :commands org-super-agenda-mode
  :custom
  (org-super-agenda-groups nil)
  (org-agenda-custom-commands
   '(("n" "Super agenda"
      ((todo ""
             ((org-super-agenda-groups
               `((:name "Overdue"
                        :deadline past)
                 (:name "Today"
                        :deadline today)
                 (:name "Soon"
                        :deadline (before ,(gx-today-plus 3)))
                 (:name "Waiting..."
                        :todo "WAIT"
                        :order 1)
                 (:name "Next"
                        :priority>= "B"
                        :order 0)
                 (:name "Todo"
                        :priority>= "C"
                        :order 3)
                 (:discard (:anything t)))))))))))

(use-package org-superstar
  :ensure
  :delight
  :hook (org-mode . org-superstar-mode)
  :custom-face
  (org-superstar-header-bullet ((t (:height 0.9))))
  :custom
  (org-superstar-cycle-headline-bullets nil)
  (org-superstar-prettify-item-bullets nil)
  (org-superstar-headline-bullets-list (quote ("●" "○")))
  (org-superstar-special-todo-items nil)
  (org-superstar-todo-bullet-alist
   (quote
    (("TODO" . 9633)
     ("WAIT" . 9633)
     ("DONE" . 9632)))))

(use-package org-agenda
  :ensure nil
  :bind ("C-c a"    . org-agenda)
  :custom
  (org-agenda-block-separator 9473)
  (org-agenda-compact-blocks nil)
  (org-agenda-use-tag-inheritance nil)
  (org-agenda-custom-commands
   '(("o" "Overdue tasks"
      ((tags-todo "SCHEDULED<\"<+0d>\"|DEADLINE<\"<+0d>\""
                  ((org-agenda-overriding-header "Overdue"))))
      nil)
     ("n" "Next tasks"
      ((tags-todo "+PRIORITY=\"A\"|+PRIORITY=\"B\"|+PRIORITY=\"C\""
                  ((org-agenda-overriding-header "Next"))))
      nil)
     ("N" "Agenda and all TODOs"
      ((tags-todo "SCHEDULED<\"<+0d>\"|DEADLINE<\"<+0d>\""
                  ((org-agenda-overriding-header "Overdue")))
       (tags-todo "+PRIORITY=\"A\"|+PRIORITY=\"B\""
                  ((org-agenda-overriding-header "Next")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))))
       (agenda "" nil))
      nil)
     ))
  (org-agenda-files '("~/org"))
  (org-agenda-inhibit-startup t)
  (org-agenda-deadline-leaders '("" "" ""))
  (org-agenda-scheduled-leaders '("" ""))
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-skip-scheduled-if-done t)
  (org-agenda-skip-timestamp-if-done t)
  (org-agenda-tags-column 90)
  (org-agenda-todo-ignore-with-date nil)
  (org-agenda-tags-todo-honor-ignore-options t)
  (org-agenda-todo-ignore-scheduled 'future)
  (org-agenda-remove-tags nil)
  (org-agenda-todo-keyword-format "%s")
  (org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s")
     (todo . " %i %-12:c")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))  
  (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (org-agenda-skip-scheduled-delay-if-deadline 'post-deadline)
  (org-agenda-skip-scheduled-if-deadline-is-shown 'not-today)
  (org-agenda-skip-timestamp-if-deadline-is-shown t)
  (org-agenda-show-future-repeats nil)
  :custom-face
  (org-agenda-structure ((t (:background nil))))
  ;; (org-agenda-structure ((t (:background nil :box (:line-width 8 :color ,(face-background 'default))))))
  (org-agenda-date ((t (:weight bold :foreground "nil":height 125))))
  (org-agenda-date-today ((t (:inverse-video nil))))
  (org-agenda-date-weekend ((t (:inherit (org-agenda-date))))))

(use-package ox-reveal
  :ensure
  :after org
  :custom
  (org-reveal-root "/usr/local/lib/node_modules/reveal.js")
  (org-reveal-reveal-js-version 4)
  (org-reveal-theme "simple"))
