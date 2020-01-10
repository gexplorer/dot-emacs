(defvar file-name-handler-alist-old file-name-handler-alist)

(setq package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      auto-window-vscroll nil)

(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect))
          t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(blink-cursor-mode -1)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)
(set-language-environment "UTF-8")
(setq w32-apps-modifier 'super)

(setq mode-line-percent-position nil)
(line-number-mode 1)
(column-number-mode 1)
(setq find-program "\"c:\\Program Files\\Git\\usr\\bin\\find.exe\"")

(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(eval-and-compile
  (require 'use-package)
  (setq use-package-compute-statistics t)
  (if init-file-debug
      (setq use-package-verbose t
            use-package-expand-minimally nil
            use-package-compute-statistics t
            debug-on-error t)
    )
  (setq use-package-verbose nil)
  (setq use-package-expand-minimally t))
(defun emacs-path (path)
    (expand-file-name path user-emacs-directory))
  (setq custom-file (emacs-path "settings.el"))
  (load custom-file)

(use-package delight)

(use-package hydra
  :ensure)

(use-package use-package-hydra
  :ensure t)

(use-package gx-utils
  :load-path "../Projects/gx-utils"
  :commands (gx-compile-current-file
             gx-convert-image-to-base64
             gx-tangle-dotemacs
             gx-eshell-new))

(use-package emacs
  :delight (buffer-face-mode nil face-remap)
  :after hydra
  :custom-face
  (default ((t (:family "Iosevka" :height 108))))
  (variable-pitch ((t (:family "Roboto" :height 108))))
  (fixed-pitch ((t (:family "Iosevka" :height 108))))
  (fixed-pitch-serif ((t (:family "Iosevka Etoile" :height 108))))
  :bind (("M-g" . hydra-goto/body))
  :hydra (hydra-goto
          ()
          ""
          ("c" goto-char "Goto char" :exit t :column "Goto")
          ("g" goto-line "Goto line" :exit t)
          ("M-g" goto-line nil :exit t)
          ("TAB" move-to-column "Move to column" :exit t)
          ("p" previous-error "Previous error" :column "Error")
          ("M-p" previous-error nil)
          ("n" next-error "Next error")
          ("M-n" next-error nil )
          ("q" nil "quit")))

(use-package solarized-theme
  :ensure
  :demand t
  :config
  (load-theme 'solarized-light))

(use-package face-remap
  :hook ((org-mode markdown-mode) . variable-pitch-mode))

(load (emacs-path "dot-org"))

(use-package undo-tree
  :ensure
  :delight
  :bind (("C-x u" . undo-tree-visualize)
         ("C-_" . undo-tree-undo)
         ("M-_" . undo-tree-redo))
  :config (global-undo-tree-mode))

(use-package ivy
  :ensure
  :hook (after-init . ivy-mode)
  :delight
  :bind ("C-x b" . ivy-switch-buffer))

(use-package ivy-rich
  :ensure
  :hook (ivy-mode . ivy-rich-mode)
  :custom
  (ivy-rich-parse-remote-buffer nil)
  (ivy-rich-display-transformers-list
   '(
     ivy-switch-buffer
     (:columns
      ((ivy-rich-candidate (:width 40))
       (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode (:width 16 :face warning))
       (ivy-rich-switch-buffer-project (:width nil :face success)))
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
      ((counsel-M-x-transformer (:width 40))
       (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
     counsel-describe-function
     (:columns
      ((counsel-describe-function-transformer (:width 40))
       (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))
     counsel-describe-variable
     (:columns
      ((counsel-describe-variable-transformer (:width 40))
       (ivy-rich-counsel-variable-docstring (:face font-lock-doc-face))))
     counsel-recentf
     (:columns
      ((ivy-rich-candidate (:width 0.8))
       (ivy-rich-file-last-modified-time (:face font-lock-comment-face))))
     package-install
     (:columns
      ((ivy-rich-candidate (:width 30))
       (ivy-rich-package-version (:width 16 :face font-lock-comment-face))
       (ivy-rich-package-archive-summary (:width 7 :face font-lock-builtin-face))
       (ivy-rich-package-install-summary (:face font-lock-doc-face)))))))

(use-package ivy-hydra
  :ensure
  :after ivy
  :commands hydra-ivy/body)

(use-package ibuffer
  :ensure
  :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-formats
   '((mark modified read-only locked " "
           (name 36 36 :left :elide)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename)))
  (ibuffer-elide-long-columns t)
  (ibuffer-expert t)
  (ibuffer-saved-filters
   '(("Programming"
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

(use-package ace-window
  :ensure
  :bind (("C-x o" . ace-window)
         ("C-x C-o" . ace-swap-window)))

(use-package swiper
  :ensure
  :after ivy
  :bind ("C-s" . swiper-isearch))

(use-package counsel
  :ensure
  :after ivy
  :hook (after-init . counsel-mode)
  :delight
  :bind (("C-c i" . counsel-imenu)
         ("C-c s" . counsel-ag))
  :bind (:map minibuffer-local-map
              ("M-r" . counsel-minibuffer-history))
  :config
  (setq counsel-async-split-string-re-alist '((t . "[\r\n]")))
  )

(use-package magit
  :ensure
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch)))

(use-package ediff
  :commands (ediff-buffers ediff-buffers3)
  :config
  (setq ediff-diff-ok-lines-regexp
        (concat
         "^\\("
         "[0-9,]+[acd][0-9,]+\C-m?$"
         "\\|[<>] "
         "\\|---"
         "\\|.*Warning *:"
         "\\|.*No +newline"
         "\\|.*No hay ning"
         "\\|.*missing +newline"
         "\\|^\C-m?$"
         "\\)"))
  (setq ediff-diff3-ok-lines-regexp
        (concat
         "^\\("
         "[1-3]:"
         "\\|===="
         "\\|  "
         "\\|.*Warning *:"
         "\\|.*No newline"
         "\\|.*No hay ning"
         "\\|.*missing newline"
         "\\|^\C-m"
         "$\\)")))

(use-package autorevert
  :delight auto-revert-mode
  :commands auto-revert-mode)

(use-package which-key
  :ensure
  :commands which-key-mode
  :delight
  :init (which-key-mode 1))

(use-package lisp-mode
  :commands (lisp-mode emacs-lisp-mode lisp-interaction-mode)
  :delight
  (lisp-mode "lisp")
  (emacs-lisp-mode "elisp")
  (lisp-interaction-mode "lisp-int")
  :bind
  ("<f9>" . gx-compile-current-file)
  ("C-<f9>" . gx-tangle-dotemacs))

(use-package auto-compile
  :ensure
  :commands (auto-compile-mode auto-compile-on-save-mode auto-compile-on-load-mode))

(use-package eldoc
  :ensure
  :delight
  :hook (prog-mode . eldoc-mode)
  :custom
  (eldoc-idle-delay 0.5))

(use-package flycheck
  :ensure
  :after hydra
  :commands (
             flycheck-mode flycheck-add-next-checker flycheck-get-next-checkers
             flycheck-buffer flycheck-clear flycheck-next-error
             flycheck-previous-error flycheck-list-errors flycheck-select-checker
             flycheck-describe-checker flycheck-disable-checker flycheck-display-error-at-point
             flycheck-explain-error-at-point display-local-help flycheck-manual
             flycheck-version flycheck-verify-setup flycheck-add-mode)
  :custom
  (flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  (flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-idle-change-delay 5)
  (flycheck-javascript-eslint-executable nil)
  (flycheck-stylelintrc ".stylelintrc")
  (flycheck-temp-prefix "flycheck")
  :bind (
         ("C-c f" . hydra-flycheck/body)
         ("<f2>" . flycheck-buffer)
         ("C-<f2>" . flycheck-list-errors)
         ("M-<f2>" . flycheck-next-error)
         ("M-S-<f2>" . flycheck-previous-error))
  :after hydra
  :hydra (hydra-flycheck
          ()
          ""
          ("c" flycheck-buffer "Check buffer" :column "Flycheck")
          ("C" flycheck-clear "Clear errors" :colored blue)
          ("n" flycheck-next-error "Next error")
          ("p" flycheck-previous-error "Previous error")
          ("l" flycheck-list-errors "List errors" :color blue)
          ("s" flycheck-select-checker "Select checker" :color blue :column "Checker")
          ("?" flycheck-describe-checker "Describe checker" :color blue)
          ("x" flycheck-disable-checker "Disable checker" :color blue)
          ("h" flycheck-display-error-at-point "Display error at point" :color blue)
          ("e" flycheck-explain-error-at-point "Explain error at point" :color blue)
          ("H" display-local-help "Display local help" :color blue :column "Help")
          ("i" flycheck-manual "Manual" :color blue)
          ("V" flycheck-version "Version" :color blue)
          ("v" flycheck-verify-setup "Verify setup" :color blue))
  :preface
  (defun gx-flycheck-add-next-checker (checker next)
    "Add NEXT checker after CHECKER if it's not already next."
    (unless (member next (flycheck-get-next-checkers checker))
      (flycheck-add-next-checker checker next)))
  
  (defun my-flycheck-setup ()
    (gx-flycheck-add-next-checker 'lsp 'javascript-eslint)
    (gx-flycheck-add-next-checker 'lsp 'typescript-tslint)
    (gx-flycheck-add-next-checker 'lsp 'scss-stylelint)
    )
  :hook ((prog-mode . flycheck-mode)
         (lsp-mode . my-flycheck-setup)))

(use-package flycheck-indicator
  :ensure
  :delight
  :hook (flycheck-mode . flycheck-indicator-mode)
  :custom
  (flycheck-indicator-icon-error 9632)
  (flycheck-indicator-icon-info 9679)
  (flycheck-indicator-icon-warning 9650)
  (flycheck-indicator-status-icons
   '((running . "◉")
     (errored . "◙")
     (finished . "●")
     (interrupted . "◘")
     (suspicious . "◘")
     (not-checked . "○"))))

(use-package flycheck-package
  :ensure
  :delight
  :after flycheck-mode)

(use-package lsp-mode
  :ensure
  :delight
  :init (setq lsp-keymap-prefix "C-c l")
  :commands (lsp lsp-deferred lsp-workspace-restart lsp lsp-workspace-shutdown
                 lsp-describe-session lsp-disconnect lsp-format-buffer lsp-format-region
                 lsp-workspace-folders-add lsp-workspace-folders-remove
                 lsp-workspace-blacklist-remove lsp-lens-mode lsp-toggle-trace-io
                 lsp-toggle-symbol-highlight lsp-ui-sideline-mode lsp-ui-doc-mode
                 lsp-toggle-signature-auto-activate lsp-toggle-on-type-formatting
                 lsp-treemacs-sync-mode lsp-find-definition lsp-find-references
                 lsp-find-implementation lsp-find-type-definition lsp-find-declaration
                 lsp-treemacs-call-hierarchy lsp-describe-thing-at-point
                 lsp-signature-activate lsp-ui-doc-glance lsp-rename lsp-organize-imports
                 lsp-execute-code-action lsp-document-highlight
                 lsp-ui-peek-find-definitions lsp-ui-peek-find-references
                 lsp-ui-peek-find-implementation lsp-ui-peek-find-workspace-symbol)
  :hook (((typescript-mode js2-mode scss-mode sh-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-auto-configure t)
  (lsp-auto-guess-root t)
  (lsp-clients-angular-language-server-command
   '("node"
     "~/AppData/Local/Yarn/Data/global/node_modules/@angular/language-server"
     "--ngProbeLocations"
     "~/AppData/Local/Yarn/Data/global/node_modules"
     "--tsProbeLocations"
     "~/AppData/Local/Yarn/Data/global/node_modules"
     "--stdio"))
  (lsp-enable-indentation nil)
  (lsp-enable-snippet nil)
  (lsp-flycheck-live-reporting t)
  (lsp-idle-delay 0.5)
  (lsp-imenu-show-container-name nil)
  (lsp-prefer-flymake nil)
  (lsp-signature-render-all nil)
  (lsp-symbol-highlighting-skip-current nil)
  (lsp-clients-typescript-plugins
   (vector
    (list :name "typescript-tslint-plugin"
          :location "~/AppData/Local/Yarn/Data/global/node_modules/typescript-tslint-plugin/")
    (list :name "@vsintellicode/typescript-intellicode-plugin"
          :location "~/.vscode/extensions/visualstudioexptteam.vscodeintellicode-1.2.6/")))
  :config (lsp-enable-which-key-integration)
  :bind (:map lsp-mode-map
              ("M-<f7>" . lsp-find-references)
              ("<f7>" . hydra-lsp/body))
  :hydra (hydra-lsp
          ()
          ("sr" lsp-workspace-restart "Restart" :column "Session")
          ("ss" lsp "Lsp")
          ("sq" lsp-workspace-shutdown "Shutdown")
          ("sd" lsp-describe-session "Describe")
          ("sD" lsp-disconnect "Disconnect")
          ("==" lsp-format-buffer "Format buffer" :column "Format")
          ("=r" lsp-format-region "Format region")
          ("Fa" lsp-workspace-folders-add "Add" :column "Folders")
          ("Fr" lsp-workspace-folders-remove "Remove")
          ("Fb" lsp-workspace-blacklist-remove "Remove blacklist")
          ("Tl" lsp-lens-mode "Lens" :column "Toggle")
          ("TL" lsp-toggle-trace-io "Trace io")
          ("Th" lsp-toggle-symbol-highlight "Symbol highlight")
          ("TS" lsp-ui-sideline-mode "Sideline")
          ("Td" lsp-ui-doc-mode "Doc")
          ("Ts" lsp-toggle-signature-auto-activate "Signature")
          ("Tf" lsp-toggle-on-type-formatting "Formatting")
          ("TT" lsp-treemacs-sync-mode "Treemacs")
          ("gg" lsp-find-definition "Definition" :column "Goto")
          ("gr" lsp-find-references "References")
          ("gi" lsp-find-implementation "Implementation")
          ("gt" lsp-find-type-definition "Type definition")
          ("gd" lsp-find-declaration "Declaration")
          ("gh" lsp-treemacs-call-hierarchy "Call hierarchy")
          ("ga" xref-find-apropos "Find apropos")
          ("hh" lsp-describe-thing-at-point "Point" :column "Help")
          ("hs" lsp-signature-activate "Signature")
          ("hg" lsp-ui-doc-glance "Doc")
          ("rr" lsp-rename "Rename" :column "Refactor")
          ("ro" lsp-organize-imports "Organize imports" :column "Actions")
          ("aa" lsp-execute-code-action "Execute action")
          ("ah" lsp-document-highlight "Highlight")
          ("Gg" lsp-ui-peek-find-definitions "Find definitions" :column "Peek")
          ("Gr" lsp-ui-peek-find-references "Find references")
          ("Gi" lsp-ui-peek-find-implementation "Find implementation")
          ("Gs" lsp-ui-peek-find-workspace-symbol "Find symbol")))

(use-package lsp-ui
  :ensure
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-border "#839496")
  (lsp-ui-doc-delay 1)
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-height 80)
  (lsp-ui-doc-max-width 120)
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-flycheck-live-reporting t)
  (lsp-ui-imenu-kind-position 'top)
  (lsp-ui-sideline-delay 0.5)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-symbol nil))

(use-package lsp-ui-flycheck
  :disabled
  :hook (lsp-after-open . lsp-flycheck-enable))

(use-package multiple-cursors
  :ensure
  :after hydra
  :bind (("M-j"   . mc/mark-next-like-this-word)
         ("M-J"   . mc/unmark-next-like-this)
         ("C-M-j" . hydra-multiple-cursors/body)
         ("C-c j n" . mc/insert-numbers)
         )
  :hydra (hydra-multiple-cursors
          ()
          "mc: "
          ("n" (call-interactively 'mc/mark-next-like-this-word) "Mark next" :column "Next")
          ("N" (call-interactively 'mc/skip-to-next-like-this) "Skip to next")
          ("M-n" (call-interactively 'mc/unmark-next-like-this) "Unmark next")
          ("p" (call-interactively 'mc/mark-previous-like-this-word) "Mark previous" :column "Previous")
          ("P" (call-interactively 'mc/skip-to-previous-like-this) "Skip to previous")
          ("M-p" (call-interactively 'mc/unmark-previous-like-this) "Unmark previous")
          ("a" (call-interactively 'mc/mark-all-like-this) "Mark all" :exit t :column "All")
          ("l" (call-interactively 'mc/edit-lines) "Edit lines" :exit t)
          ("b" (call-interactively 'mc/edit-beginnings-of-lines) "Edit beginnings of lines" :exit t)
          ("0" (call-interactively 'mc/insert-numbers) "Insert numbers" :exit t :column "Edit")
          ("A" (call-interactively 'mc/insert-letters) "Insert letters" :exit t))
  :config
  (add-to-list 'mc/cmds-to-run-once 'swiper-mc))

(use-package expand-region
  :ensure
  :bind ("C-c w" . er/expand-region))

(use-package crux
  :ensure
  :bind (("C-c I"   . crux-find-user-init-file)
	 ;; ("C-k"     . crux-smart-kill-line)
	 ("C-a"     . crux-move-beginning-of-line)
	 ("C-M-l"   . crux-indent-defun)
	 ("C-c d"   . crux-duplicate-current-line-or-region)
	 ("C-x C-o" . crux-transpose-windows)))

(use-package move-text
  :ensure
  :bind (("C-S-n" . move-text-down)
         ("C-S-p" . move-text-up)))

(use-package projectile
  :ensure
  :commands projectile-mode
  :bind-keymap ("C-c p" . projectile-command-map)
  :delight '(:eval
             (let ((project-name (projectile-project-name))
                   (project-type (projectile-project-type)))
               (format "[%s%s]"
                       (propertize (or (projectile-project-name) "-")
                                   'font-lock-face 'font-lock-builtin-face)
                       (if project-type
                           (format ":%s" project-type)
                         ""))))
  :custom
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode 1)
  (ivy-add-actions
   'projectile-switch-project
   '(("v" projectile-vc "open project with magit"))))

(use-package ibuffer-vc
  :ensure
  :after ibuffer
  :commands (ibuffer-vc-set-filter-groups-by-vc-root ibuffer-do-sort-by-alphabetic)
  :preface
  (defun my-ibuffer-vc-setup ()
    (ibuffer-vc-set-filter-groups-by-vc-root)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  :hook (ibuffer . my-ibuffer-vc-setup))

(use-package counsel-projectile
  :ensure
  :after counsel
  :delight
  :bind ("C-c C-p" . hydra-counsel-projectile/body)
  :hydra (hydra-counsel-projectile
          (:exit t)
          ""
          ("f" counsel-projectile-find-file "Find file" :column "Find")
          ("g" counsel-projectile-find-file-dwim "Find file dwim")
          ("d" counsel-projectile-find-dir "Find dir")
          ("s g" counsel-projectile-grep "grep")
          ("s s" counsel-projectile-ag "ag")
          ("b" counsel-projectile-switch-to-buffer "Switch to buffer" :column "Buffer")
          ("I" projectile-ibuffer "IBuffer")
          ("k" projectile-kill-buffers "Kill buffer")
          ("p" counsel-projectile-switch-project "Switch project" :column "Project")
          ("i" projectile-invalidate-cache "Invalidate cache")
          ("c" projectile-compile-project "Compile")
          ("D" projectile-dired "Dired")))

(use-package rainbow-delimiters
  :ensure
  :hook ((lisp-mode emacs-lisp-mode) . rainbow-delimiters-mode))

(use-package elec-pair
  :ensure
  :hook (prog-mode . electric-pair-mode))

(use-package paren
  :ensure
  :hook (prog-mode . show-paren-mode))

(use-package smartparens
  :disabled
  :ensure
  :delight
  :commands (sp-local-pair)
  :config
  (sp-local-pair '(lisp-mode emacs-lisp-mode) "`" "'" :when '(sp-in-string-p sp-in-comment-p))
  (sp-local-pair '(lisp-mode emacs-lisp-mode) "'" nil :actions nil)
  :hook (
         ;; (prog-mode . smartparens-mode)
         (prog-mode . show-smartparens-mode)
         ((lisp-mode emacs-lisp-mode) . smartparens-strict-mode))
  )

(use-package smartparens-config
  :disabled
  :ensure
  :hook (prog-mode . turn-on-smartparens-strict-mode)
  :config (progn (show-smartparens-global-mode t)))

(use-package powershell
  :ensure
  :mode ("\\.ps[dm]?1\\'" . powershell-mode))

(use-package eshell
  :ensure
  :commands eshell
  :bind (([remap eshell-pcomplete]   . completion-at-point))
  :config
  (defadvice eshell-handle-ansi-color (around test activate)
    "Handle ANSI color codes."
    (ansi-color-apply-on-region (1- eshell-last-output-start)
                                (1- eshell-last-output-end)))
  (defun eshell-new()
    "Open a new instance of eshell."
    (interactive)
    (eshell 'N)))

(use-package js2-mode
  :ensure
  :delight "js2"
  :mode "\\.js\\'"
  :config
  (setq js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute"
                             "setTimeout" "clearTimeout" "setInterval" "clearInterval"
                             "location" "__dirname" "console" "JSON" "process")))

(use-package rjsx-mode
  :ensure
  :mode "\\.jsx\\'")

(use-package js
  :ensure
  :delight "js"
  :commands js-mode)

(use-package vue-mode
  :ensure
  :mode "\\.vue\\'")

(use-package add-node-modules-path
  :ensure
  :hook ((js2-mode typescript-mode) . add-node-modules-path))

(use-package prettier-js
  :disabled
  :ensure
  :delight
  :hook (js2-mode . prettier-js-mode))

(use-package json-mode
  :ensure
  :mode "\\.json\\'")

(use-package typescript-mode
  :ensure
  :delight "ts"
  :mode "\\.ts\\'")

(use-package company
  :disabled
  :ensure
  :hook (prog-mode . company-mode)
  :bind (:map company-mode-map
              ("C-M-i" . company-complete)))

(use-package company
  :disabled
  :ensure
  :delight
  :hook (prog-mode . company-mode)
  :bind (("C-M-i" . company-complete))
  :bind (:map company-active-map
              ("<SPC>" . company-filter-candidates))
  :bind (:map company-filter-map
              ("<SPC>" . self-insert-command))
  :bind (:map lisp-interaction-mode-map
              ("C-M-i" . company-complete))
  :bind (:map emacs-lisp-mode-map
              ("C-M-i" . company-complete))
  :bind (:map lisp-mode-map
              ("C-M-i" . company-complete)))

(use-package company-posframe
  :disabled
  :ensure
  :delight
  :after company
  :hook (company-mode . company-posframe-mode))

(use-package company-web
  :disabled
  :ensure
  :after (company web-mode)
  :preface
  (defun my-company-web-setup ()
    (set (make-local-variable 'company-backends) '(company-web-html)))
  :hook (web-mode . my-company-web-setup))

(use-package company-lsp
  :disabled
  :ensure
  :after (company lsp-mode)
  :preface
  (defun my-company-lsp-setup ()
    (add-to-list 'company-backends 'company-lsp))
  :hook (lsp-mode . my-company-lsp-setup))

(use-package web-mode
  :ensure
  :after hydra
  :mode "\\.html\\'"
  :commands (
             web-mode-element-beginning web-mode-element-parent web-mode-element-child
             web-mode-element-next web-mode-element-previous web-mode-element-end
             web-mode-element-insert web-mode-element-wrap web-mode-element-clone
             web-mode-element-rename web-mode-element-kill web-mode-element-vanish
             web-mode-element-transpose web-mode-element-close web-mode-element-select
             web-mode-element-content-select web-mode-element-children-fold-or-unfold
             web-mode-element-extract web-mode-element-contract
             web-mode-attribute-beginning web-mode-attribute-previous web-mode-attribute-next
             web-mode-attribute-end web-mode-attribute-insert web-mode-attribute-select
             web-mode-attribute-kill web-mode-attribute-transpose
             web-mode-block-beginning web-mode-block-previous web-mode-block-next web-mode-block-end
             web-mode-block-select web-mode-block-kill web-mode-block-close
             web-mode-tag-beginning web-mode-tag-previous web-mode-tag-next web-mode-tag-end
             web-mode-tag-match web-mode-tag-select web-mode-tag-attributes-sort
             web-mode-dom-apostrophes-replace web-mode-dom-errors-show web-mode-dom-entities-replace
             web-mode-dom-normalize web-mode-dom-quotes-replace web-mode-dom-traverse
             web-mode-dom-xpath web-mode-set-content-type
             )
  :init
  (defun my-web-mode-setup ()
    (if (equal web-mode-content-type "javascript")
        (web-mode-set-content-type "jsx")
      (message "now set to: %s" web-mode-content-type)))
  :hook (web-mode . my-web-mode-setup)
  :bind (:map web-mode-map
              ("C-c C-e" . hydra-web-mode-element/body)
              ("C-c C-a" . hydra-web-mode-attribute/body)
              ("C-c C-b" . hydra-web-mode-block/body)
              ("C-c C-t" . hydra-web-mode-tag/body)
              ("C-c C-d" . hydra-web-mode-dom/body)
              )
  :hydra (hydra-web-mode-element
          ()
          ""
          ("a" web-mode-element-beginning "Beginning" :column "Move")
          ("u" web-mode-element-parent "Parent")
          ("d" web-mode-element-child "Child")
          ("n" web-mode-element-next "Next")
          ("p" web-mode-element-previous "Previous")
          ("e" web-mode-element-end "End")
          ("i" web-mode-element-insert "Insert" :column "Edit" :exit t)
          ("w" web-mode-element-wrap "Wrap" :exit t)
          ("c" web-mode-element-clone "Clone" :exit t)
          ("r" web-mode-element-rename "Rename" :exit t)
          ("k" web-mode-element-kill "Kill" :exit t)
          ("v" web-mode-element-vanish "Vanish" :exit t)
          ("t" web-mode-element-transpose "Transpose")
          ("/" web-mode-element-close "Close" :exit t)
          ("s" web-mode-element-select "Select" :column "Select" :exit t)
          ("S" web-mode-element-content-select "Content select" :exit t)
          ("f" web-mode-element-children-fold-or-unfold "(Un)fold children" :column "Children")
          ("+" web-mode-element-extract "Extract")
          ("-" web-mode-element-contract "Contract")
          )
  :hydra (hydra-web-mode-attribute
          ()
          ""
          ("a" web-mode-attribute-beginning "Beginning" :column "Move")
          ("p" web-mode-attribute-previous "Previous")
          ("n" web-mode-attribute-next "Next")
          ("e" web-mode-attribute-end "End")
          ("i" web-mode-attribute-insert "Insert" :column "Edit" :exit t)
          ("s" web-mode-attribute-select "Select" :exit t)
          ("k" web-mode-attribute-kill "Kill" :exit t)
          ("t" web-mode-attribute-transpose "Transpose")
          )
  :hydra (hydra-web-mode-block
          ()
          ""
          ("a" web-mode-block-beginning "Beginning" :column "Move")
          ("p" web-mode-block-previous "Previous")
          ("n" web-mode-block-next "Next")
          ("e" web-mode-block-end "End")
          ("s" web-mode-block-select "Select" :column "Edit" :exit t)
          ("k" web-mode-block-kill "Kill" :exit t)
          ("c" web-mode-block-close "Close" :exit t)
          )
  :hydra (hydra-web-mode-tag
          ()
          ""
          ("a" web-mode-tag-beginning "Beginning" :column "Move")
          ("p" web-mode-tag-previous "Previous")
          ("n" web-mode-tag-next "Next")
          ("e" web-mode-tag-end "End")
          ("m" web-mode-tag-match "Match")
          ("s" web-mode-tag-select "Select" :column "Edit" :exit t)
          ("x" web-mode-tag-attributes-sort "Sort attributes" :exit t)
          )
  :hydra (hydra-web-mode-dom
          ()
          ""
          ("a" web-mode-dom-apostrophes-replace "Replace apostrophes")
          ("d" web-mode-dom-errors-show "Show errors")
          ("e" web-mode-dom-entities-replace "Replace entities")
          ("n" web-mode-dom-normalize "Normalize")
          ("q" web-mode-dom-quotes-replace "Replace quotes")
          ("t" web-mode-dom-traverse "Traverse")
          ("x" web-mode-dom-xpath "xpath")
          )
  )

(use-package handlebars-mode
  :ensure
  :delight "hbs"
  :mode "\\.hbs\\'")

(use-package csharp-mode
  :ensure
  :mode "\\.cs\\'")

(use-package omnisharp
  :ensure
  :delight
  :commands (omnisharp-mode))

(use-package ag
  :ensure
  :disabled)

(use-package wgrep
  :ensure
  :commands wgrep-change-to-wgrep-mode)

(use-package restclient
  :ensure
  :mode ("\\.http\\'" . restclient-mode))

(use-package ob-http
  :ensure
  :after org-mode)

(use-package olivetti
  :ensure
  :commands olivetti-mode)

(use-package feature-mode
  :ensure
  :mode "\\.feature\\'")

(use-package markdown-mode
  :ensure t
  :delight "md"
  :mode "\\.md\\'"
  :commands markdown-update-header-faces
  :custom
  (markdown-asymmetric-header nil)
  (markdown-command "pandoc")
  (markdown-header-scaling nil)
  (markdown-header-scaling-values '(1.1))
  (markdown-hide-markup nil)
  (markdown-list-item-bullets '("•"))
  (markdown-marginalize-headers nil)
  (markdown-css-paths '("file://c:/Users/eelor/Projects/markdown-themes/modest.css"))
  :custom-face
  (markdown-code-face ((t (:inherit (fixed-pitch highlight)))))
  (markdown-inline-code-face ((t (:inherit (fixed-pitch highlight)))))
  (markdown-header-face-1 ((t (:height 1.1 :underline nil))))
  (markdown-header-face-2 ((t (:height 1.1))))
  (markdown-header-face-3 ((t (:height 1.1))))
  :config
  (markdown-update-header-faces markdown-header-scaling))

(use-package simple
  :disabled
  :commands (visual-line-mode toggle-truncate-lines)
  :hook ((org-mode markdown-mode) . (progn (toggle-truncate-lines 1))))

(use-package font-lock-studio
  :ensure t
  :commands (font-lock-studio))

(use-package yasnippet
  :ensure t
  :delight yas-minor-mode
  :commands (yas-minor-mode))

(use-package string-inflection
  :ensure t
  :delight
  :bind (("C-c C-u" . string-inflection-all-cycle)))

(use-package graphviz-dot-mode
  :ensure t
  :mode "\\.dot\\'")

(use-package cask-mode
  :ensure t
  :mode "[Cc]ask\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

(use-package choicescript-mode
  :load-path "../Projects/choicescript-mode"
  :delight "chs"
  :commands choicescript-mode)

(use-package simple-modeline
  :ensure t
  :hook (after-init . simple-modeline-mode))

(use-package ag-popup
  :load-path "../Projects/grep-popup"
  :commands (ag-popup))

(use-package counsel-ag-popup
  :load-path "../Projects/counsel-ag-popup"
  :bind ("C-c s" . counsel-ag-popup))

(use-package ng-cli
  :load-path "../Projects/ng-cli"
  :commands (ng-cli-build ng-cli-serve ng-cli-lint))

(use-package log-view
  :mode ("\\.log\\'" . log-view-mode))

;; (put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
