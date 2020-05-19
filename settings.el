(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-reuse-buffers nil)
 '(aw-dispatch-always nil)
 '(aw-ignore-current t)
 '(aw-scope (quote frame))
 '(counsel-mode-override-describe-bindings t)
 '(counsel-org-headline-display-priority nil)
 '(counsel-projectile-ag-initial-input nil)
 '(counsel-projectile-sort-buffers t)
 '(counsel-projectile-sort-directories t)
 '(counsel-projectile-sort-files t)
 '(counsel-projectile-sort-projects nil)
 '(counsel-yank-pop-separator "
----
")
 '(counsel-yank-pop-truncate-radius 3)
 '(css-indent-offset 4)
 '(ctl-arrow t)
 '(cursor-type (quote box))
 '(custom-buffer-done-kill t)
 '(custom-buffer-verbose-help nil)
 '(custom-magic-show (quote long))
 '(custom-magic-show-button nil)
 '(custom-raised-buttons t)
 '(custom-reset-button-menu t)
 '(custom-safe-themes
   (quote
    ("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7d56fb712ad356e2dacb43af7ec255c761a590e1182fe0537e1ec824b7897357" "97965ccdac20cae22c5658c282544892959dc541af3e9ef8857dbf22eb70e82b" "9129c2759b8ba8e8396fe92535449de3e7ba61fd34569a488dd64e80f5041c9f" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default)))
 '(custom-search-field nil)
 '(default-input-method "rfc1345")
 '(defun-prompt-regexp nil)
 '(delete-by-moving-to-trash t)
 '(delete-selection-mode t)
 '(diff-hl-side (quote right))
 '(directory-abbrev-alist nil)
 '(dired-listing-switches "-alh")
 '(display-line-numbers nil)
 '(doc-view-ghostscript-program "c:/Program Files/gs/gs9.23/bin/gswin64.exe")
 '(dynamic-completion-mode nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(eldoc-idle-delay 0.5)
 '(enable-completion nil)
 '(fill-column 100)
 '(flycheck-indicator-icon-error 9632 nil nil "Customized with use-package flycheck-indicator")
 '(flycheck-indicator-icon-info 9679 nil nil "Customized with use-package flycheck-indicator")
 '(flycheck-indicator-icon-warning 9650 nil nil "Customized with use-package flycheck-indicator")
 '(flycheck-indicator-mode t)
 '(flycheck-indicator-status-icons
   (quote
    ((running . "◉")
     (errored . "◙")
     (finished . "●")
     (interrupted . "◘")
     (suspicious . "◘")
     (not-checked . "○"))))
 '(fringe-mode 12 nil (fringe))
 '(highlight-nonselected-windows nil)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-expert t)
 '(ibuffer-formats
   (quote
    ((mark modified read-only locked " "
           (name 36 36 :left :elide)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename))))
 '(ibuffer-saved-filters
   (quote
    (("Programming"
      (and
       (derived-mode . prog-mode)
       (not
        (starred-name))
       (not
        (filename . ".emacs.d"))))
     ("Magit"
      (derived-mode . magit-mode))
     ("emacs"
      (or
       (mode . Custom-mode)
       (filename . ".emacs.d")))
     ("Org"
      (mode . org-mode))
     ("Help"
      (mode . help-mode)))))
 '(idle-update-delay 1)
 '(imenu-auto-rescan t)
 '(imenu-sort-function (quote imenu--sort-by-name))
 '(imenu-use-markers t)
 '(indent-tabs-mode nil)
 '(inhibit-default-init nil)
 '(inhibit-startup-echo-area-message "gexplorer")
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((menu-bar-lines . 0) (tool-bar-lines . 0))))
 '(initial-scratch-message nil)
 '(ivy-count-format "")
 '(ivy-extra-directories (quote ("./")))
 '(ivy-format-function (quote ivy-format-function-line) t)
 '(ivy-height 20)
 '(ivy-ignore-buffers (quote ("\\` ")))
 '(ivy-mode t)
 '(ivy-rich-display-transformers-list
   (quote
    (ivy-switch-buffer
     (:columns
      ((ivy-rich-candidate
        (:width 40))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 16 :face warning))
       (ivy-rich-switch-buffer-project
        (:width nil :face success)))
      :predicate
      (lambda
        (cand)
        (get-buffer cand)))
     counsel-find-file
     (:columns
      ((ivy-read-file-transformer)
       (ivy-rich-counsel-find-file-truename
        (:face font-lock-doc-face))))
     counsel-M-x
     (:columns
      ((counsel-M-x-transformer
        (:width 40))
       (ivy-rich-counsel-function-docstring
        (:face font-lock-doc-face))))
     counsel-describe-function
     (:columns
      ((counsel-describe-function-transformer
        (:width 40))
       (ivy-rich-counsel-function-docstring
        (:face font-lock-doc-face))))
     counsel-describe-variable
     (:columns
      ((counsel-describe-variable-transformer
        (:width 40))
       (ivy-rich-counsel-variable-docstring
        (:face font-lock-doc-face))))
     counsel-recentf
     (:columns
      ((ivy-rich-candidate
        (:width 0.8))
       (ivy-rich-file-last-modified-time
        (:face font-lock-comment-face))))
     package-install
     (:columns
      ((ivy-rich-candidate
        (:width 30))
       (ivy-rich-package-version
        (:width 16 :face font-lock-comment-face))
       (ivy-rich-package-archive-summary
        (:width 7 :face font-lock-builtin-face))
       (ivy-rich-package-install-summary
        (:face font-lock-doc-face)))))))
 '(ivy-rich-parse-remote-buffer nil)
 '(ivy-use-virtual-buffers t)
 '(js2-global-externs
   (quote
    ("expect" "describe" "test" "beforeEach" "it" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "process")))
 '(js2-mode-show-parse-errors t)
 '(js2-mode-show-strict-warnings t)
 '(lsp-ui-doc-border "#839496")
 '(magit-auto-revert-mode nil)
 '(magit-bisect-show-graph nil)
 '(magit-commit-show-diff nil)
 '(magit-diff-highlight-hunk-body nil)
 '(magit-diff-highlight-hunk-region-functions
   (quote
    (magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-overlays)))
 '(magit-diff-highlight-trailing nil)
 '(magit-diff-paint-whitespace nil)
 '(magit-diff-refine-hunk t)
 '(magit-diff-refine-ignore-whitespace t)
 '(magit-diff-unmarked-lines-keep-foreground t)
 '(magit-log-section-commit-count 5)
 '(magit-module-sections-nested nil)
 '(magit-pull-or-fetch nil)
 '(magit-section-visibility-indicator
   (quote
    (magit-fringe-bitmap-bold> . magit-fringe-bitmap-boldv)))
 '(magit-status-headers-hook
   (quote
    (magit-insert-error-header magit-insert-diff-filter-header magit-insert-head-branch-header magit-insert-upstream-branch-header magit-insert-push-branch-header)))
 '(magit-status-margin (quote (nil age magit-log-margin-width t 18)))
 '(magit-status-show-hashes-in-headers nil)
 '(markdown-asymmetric-header nil)
 '(markdown-command "pandoc")
 '(markdown-header-scaling nil)
 '(markdown-header-scaling-values (quote (1.1)))
 '(markdown-hide-markup nil)
 '(markdown-list-item-bullets (quote ("•")))
 '(markdown-marginalize-headers nil)
 '(menu-bar-mode nil)
 '(mode-line-default-help-echo nil)
 '(olivetti-body-width 100)
 '(olivetti-minimum-body-width 70)
 '(omnisharp-server-executable-path nil)
 '(org-adapt-indentation nil)
 '(org-agenda-compact-blocks nil)
 '(org-agenda-custom-commands
   (quote
    (("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (todo "NEXT|WAITING"
             ((org-agenda-overriding-header "Next:"))))
      nil))))
 '(org-agenda-files (quote ("~/Dropbox/org/" "~/Dropbox/org/work/")))
 '(org-agenda-persistent-filter t)
 '(org-agenda-scheduled-leaders (quote ("Scheduled: " "Sched.%2dx: ")))
 '(org-agenda-show-future-repeats nil)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-agenda-todo-ignore-with-date t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (shell . t) (sql . t))))
 '(org-blank-before-new-entry (quote ((heading . auto) (plain-list-item . auto))))
 '(org-bullets-bullet-list (quote ("●" "○" "○" "○" "○" "○" "○" "○")))
 '(org-capture-templates
   (quote
    (("w" "Work" entry
      (file "~/Dropbox/org/Work/Work.org")
      ""))) t)
 '(org-catch-invisible-edits (quote smart))
 '(org-cycle-level-faces nil)
 '(org-cycle-separator-lines 2)
 '(org-deadline-warning-days 3)
 '(org-directory "~/Dropbox/org")
 '(org-ellipsis "…")
 '(org-fontify-done-headline t)
 '(org-hide-block-startup nil)
 '(org-hide-emphasis-markers t)
 '(org-hide-leading-stars t)
 '(org-highlight-links (quote (bracket angle plain radio tag date footnote)))
 '(org-image-actual-width t)
 '(org-insert-heading-respect-content t)
 '(org-log-done-with-time nil)
 '(org-log-note-headings
   (quote
    ((done . "CLOSING NOTE %t")
     (state . "")
     (note . "Note taken on %t")
     (reschedule . "Rescheduled from %S on %t")
     (delschedule . "Not scheduled, was %S on %t")
     (redeadline . "New deadline from %S on %t")
     (deldeadline . "Removed deadline, was %S on %t")
     (refile . "Refiled on %t")
     (clock-out . ""))))
 '(org-log-repeat (quote time))
 '(org-modules (quote (org-bbdb org-docview org-info org-w3m)))
 '(org-pretty-entities nil)
 '(org-priority-faces (quote ((65 . "#cb4b16") (66 . "#b58900"))))
 '(org-refile-targets (quote ((org-agenda-files :level . 1))))
 '(org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0/" t)
 '(org-special-ctrl-a/e t)
 '(org-special-ctrl-k t)
 '(org-startup-folded nil)
 '(org-startup-with-inline-images t)
 '(org-tags-column 0)
 '(org-todo-keyword-faces (quote (("NEXT" . "#2aa198") ("WAIT" . "#268bd2"))))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "DONE(d)"))))
 '(org-use-fast-todo-selection t)
 '(overflow-newline-into-fringe t)
 '(overline-margin 1)
 '(package-selected-packages
   (quote
    (minions org-superstar 2048-game simple-modeline ibuffer-vc rjsx-mode smart-mode-line-powerline-theme smart-mode-line org-plus-contrib ivy-rich posframe ivy-posframe ivy-hydra darkroom mocha lsp-ui-flycheck yaml-mode yasnippet wgrep-ag request ox-reveal dired csharp-mode lsp-mode ivy org-preview-html htmlize js-comint smartparens-config string-inflection cask-mode doom-modeline graphviz-dot-mode gulp-task-runner mixed-pitch tablist olivetti restclient counsel-projectile counsel magit mood-line poet-theme js2-refactor use-package-hydra bnf-mode font-lock-studio xah-fly-keys flycheck-indicator polymode logview handlebars-mode feature-mode wgrep powershell ob-http c-sharp omnisharp flycheck-package package-lint flycheck-color-mode-line spaceline transient ag hydra 0blayout vue-mode org-bullets add-node-modules-path eval-expr simple move-text auto-compile prettier-js json-mode js2-mode lsp-ui typescript-mode tyepscript-mode rainbow-delimiters web-mode delight smartparens projectile crux expand-region multiple-cursors which-key swiper ace-window undo-tree solarized-theme use-package)))
 '(projectile-indexing-method (quote alien))
 '(ring-bell-function (quote ignore))
 '(rm-whitelist "FlyC")
 '(safe-local-variable-values
   (quote
    ((package-lint-main-file . "simple-modeline.el")
     (eval when
           (and
            (buffer-file-name)
            (not
             (file-directory-p
              (buffer-file-name)))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (unless
               (featurep
                (quote package-build))
             (let
                 ((load-path
                   (cons "../package-build" load-path)))
               (require
                (quote package-build))))
           (unless
               (derived-mode-p
                (quote emacs-lisp-mode))
             (emacs-lisp-mode))
           (package-build-minor-mode)
           (setq-local flycheck-checkers nil)
           (set
            (make-local-variable
             (quote package-build-working-dir))
            (expand-file-name "../working/"))
           (set
            (make-local-variable
             (quote package-build-archive-dir))
            (expand-file-name "../packages/"))
           (set
            (make-local-variable
             (quote package-build-recipes-dir))
            default-directory))
     (projectile-project-root . "~/Projects/KiroOncology/HMI/src/KiroGrifols.KiroOncology.Hmi.Web/")
     (projectile-project-root . default-directory)
     (projectile-project-type . "angular")
     (projectile-project-root . "HMI/src/KiroGrifols.KiroOncology.Hmi.Web/")
     (projectile-project-root . "HMI/src")
     (projectile-project-root . "HMI")
     (projectile-project-root . ".")
     (projectile-project-compilation-dir . "HMI/src")
     (projectile-project-compilation-dir . "HMI/src/KiroGrifols.KiroOncology.Hmi.Web/")
     (projectile-project-type quote angular)
     (projectile-project-name . "KiroKon.Web")
     (projectile-project-root . "~/Projects/KiroOncology/HMI/src/KiroGrifols.KiroOncology.Hmi.Web"))))
 '(selective-display-ellipses t)
 '(server-switch-hook nil)
 '(shell-file-name
   "c:/ProgramData/chocolatey/lib/Emacs/tools/emacs/libexec/emacs/26.2/x86_64-w64-mingw32/cmdproxy.exe")
 '(show-paren-when-point-in-periphery t)
 '(show-paren-when-point-inside-paren t)
 '(simple-modeline-mode t)
 '(simple-modeline-show-cursor-point nil)
 '(simple-modeline-show-encoding nil)
 '(simple-modeline-show-encoding-information nil)
 '(simple-modeline-show-eol nil)
 '(simple-modeline-show-eol-style nil)
 '(simple-modeline-show-input-method t)
 '(simple-modeline-show-misc-info t)
 '(simple-modeline-show-modified t)
 '(simple-modeline-show-percent-position nil)
 '(simple-modeline-show-vc t)
 '(solarized-height-minus-1 0.8)
 '(solarized-height-plus-2 1.1)
 '(solarized-height-plus-3 1.1)
 '(solarized-height-plus-4 1.1)
 '(solarized-high-contrast-mode-line nil)
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-more-italic t)
 '(solarized-use-variable-pitch nil)
 '(sp-base-key-bindings (quote sp))
 '(sql-connection-alist
   (quote
    (("KiroKon"
      (sql-product
       (quote ms))
      (sql-server "np:\\\\.\\pipe\\LOCALDB#F4279E6E\\tsql\\query")))))
 '(sql-ms-program "sqlcmd")
 '(tooltip-mode t)
 '(truncate-lines t)
 '(truncate-partial-width-windows 80)
 '(twee-tweego-executable "tweego")
 '(twee-twine-workspace "~/Documents/Twine/Stories/")
 '(typescript-enabled-frameworks (quote (typescript)))
 '(typescript-flat-functions t)
 '(undo-tree-history-directory-alist (quote ((".*" . "c:/Users/eelor/AppData/Local/Temp/"))))
 '(web-mode-auto-close-style 1)
 '(web-mode-enable-block-face nil)
 '(web-mode-enable-css-colorization nil)
 '(web-mode-enable-current-column-highlight nil)
 '(web-mode-enable-current-element-highlight nil)
 '(web-mode-enable-element-content-fontification nil)
 '(web-mode-enable-element-tag-fontification nil)
 '(web-mode-enable-engine-detection t)
 '(web-mode-enable-html-entities-fontification t)
 '(wgrep-auto-save-buffer t)
 '(which-key-max-description-length 40)
 '(which-key-max-display-columns 5)
 '(whitespace-line-column nil)
 '(word-wrap t)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :height 110))))
 '(aw-background-face ((t (:inherit font-lock-comment-face))))
 '(aw-leading-char-face ((t (:foreground "red" :weight bold))))
 '(bold ((t (:weight bold))))
 '(bold-italic ((t (:inherit bold :slant italic))))
 '(choicescript-mode-text-face ((t nil)))
 '(compilation-info ((((class color) (min-colors 89)) (:foreground "#586e75" :underline nil :bold nil))))
 '(css-selector ((t (:inherit font-lock-type-face))))
 '(custom-comment ((t (:inherit font-lock-doc-face))))
 '(custom-documentation ((t (:inherit variable-pitch))))
 '(fixed-pitch ((t (:inherit default :family "Iosevka"))))
 '(fixed-pitch-serif ((t (:family "PT Serif"))))
 '(flycheck-indicator-running ((t (:inherit success))))
 '(flycheck-indicator-success ((t nil)))
 '(ivy-minibuffer-match-face-1 ((((class color) (min-colors 89)) (:foreground "#586e75"))))
 '(ivy-minibuffer-match-face-2 ((((class color) (min-colors 89)) (:foreground "#b58900"))))
 '(ivy-org ((t (:inherit font-lock-doc-face))))
 '(ivy-virtual ((t (:inherit font-lock-comment-face))))
 '(line-number-current-line ((t (:inherit default :weight bold))))
 '(lsp-ui-doc-background ((t (:inherit highlight))))
 '(lsp-ui-doc-header ((t (:inherit font-lock-string-face :weight bold))))
 '(lsp-ui-sideline-global ((t (:inherit highlight :slant italic))))
 '(lsp-ui-sideline-symbol-info ((t (:slant italic))))
 '(lv-separator ((t (:inherit highlight))))
 '(magit-mode-line-process ((t (:inherit font-lock-string-face :weight bold))))
 '(markdown-code-face ((t (:inherit bold))))
 '(markdown-header-face-1 ((t (:height 1.1))))
 '(markdown-header-face-2 ((t (:height 1.1))))
 '(markdown-header-face-3 ((t (:height 1.1))))
 '(markdown-inline-code-face ((t (:inherit (fixed-pitch highlight)))))
 '(mmm-default-submode-face ((t nil)))
 '(mode-line ((t (:box nil))))
 '(mode-line-emphasis ((t (:inherit success :weight bold))))
 '(mode-line-highlight ((t (:box 2))))
 '(mode-line-inactive ((t (:box nil))))
 '(org-agenda-date ((t (:inherit variable-pitch :weight bold :foreground nil :height 125))))
 '(org-agenda-date-today ((t (:inverse-video nil))))
 '(org-agenda-date-weekend ((t (:foreground nil :underline t))))
 '(org-agenda-structure ((t (:inherit variable-pitch))))
 '(org-block ((t (:inherit (highlight fixed-pitch)))))
 '(org-block-begin-line ((t (:inherit (highlight fixed-pitch)))))
 '(org-block-end-line ((t (:inherit (highlight fixed-pitch)))))
 '(org-date ((t (:inherit fixed-pitch :underline nil))))
 '(org-document-info-keyword ((t (:inherit (org-meta-line fixed-pitch)))))
 '(org-document-title ((t (:height 1.0))))
 '(org-done ((t (:foreground nil :strike-through t :inherit (shadow fixed-pitch)))))
 '(org-headline-done ((t (:foreground nil))))
 '(org-hide ((t (:inherit fixed-pitch))))
 '(org-level-1 ((t (:foreground nil :height 1.0))))
 '(org-level-2 ((t (:foreground nil :height 1.0))))
 '(org-level-3 ((t (:foreground nil :height 1.0))))
 '(org-level-4 ((t (:foreground nil :height 1.0))))
 '(org-level-5 ((t (:foreground nil :height 1.0))))
 '(org-level-6 ((t (:foreground nil :height 1.0))))
 '(org-level-7 ((t (:foreground nil :height 1.0))))
 '(org-level-8 ((t (:foreground nil :height 1.0))))
 '(org-meta-line ((t (:inherit fixed-pitch))))
 '(org-priority ((t (:inherit fixed-pitch :weight bold))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-scheduled ((t (:foreground nil))))
 '(org-scheduled-previously ((t (:foreground "#93a1a1"))))
 '(org-scheduled-today ((t (:foreground "#586e75"))))
 '(org-special-keyword ((t (:inherit fixed-pitch))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-tag ((t (:inherit fixed-pitch))))
 '(org-todo ((t (:inherit fixed-pitch :foreground nil :weight bold))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch highlight)))))
 '(typescript-jsdoc-tag ((t (:inherit font-lock-builtin-face))))
 '(typescript-jsdoc-type ((t (:inherit font-lock-keyword-face))))
 '(typescript-jsdoc-value ((t (:inherit font-lock-variable-name-face))))
 '(variable-pitch ((t (:inherit default :height 1.2 :family "Lato"))))
 '(vc-conflict-state ((t (:inherit (vc-state-base error)))))
 '(vc-edited-state ((t (:inherit (vc-state-base font-lock-variable-name-face)))))
 '(vc-locally-added-state ((t (:inherit (vc-state-base success)))))
 '(vc-locked-state ((t (:inherit (vc-state-base shadow)))))
 '(vc-missing-state ((t (:inherit (vc-state-base error)))))
 '(vc-needs-update-state ((t (:inherit (vc-state-base warning)))))
 '(vc-removed-state ((t (:inherit (vc-state-base error)))))
 '(vc-state-base ((t nil)))
 '(web-mode-bold-face ((t (:weight bold))))
 '(web-mode-current-column-highlight-face ((t (:inherit highlight))))
 '(which-key-local-map-description-face ((t (:inherit which-key-command-description-face :slant italic)))))
