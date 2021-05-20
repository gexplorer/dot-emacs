(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
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
                   gc-cons-threshold 100000000
                   gc-cons-percentage 0.1)
             (garbage-collect))
          t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode 1)
(column-number-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(set-language-environment "UTF-8")

(setq inhibit-startup-screen t
      ring-bell-function 'ignore
      overline-margin 2
      x-underline-at-descent-line t)

(setq create-lockfiles nil
      auto-save-default nil
      make-backup-files nil
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(put 'dired-find-alternate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(eval-and-compile
  (require 'package)
  (add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/"))
  (package-initialize)

  (unless package-archive-contents
    (package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))
  (require 'use-package)

  (unless (package-installed-p 'delight)
    (package-install 'delight))
  (require 'delight)
  
  (setq use-package-always-ensure t
        use-package-verbose nil
        use-package-expand-minimally t
        use-package-compute-statistics t))

(defun emacs-path (path)
  (expand-file-name path user-emacs-directory))

(setq custom-file (emacs-path "settings.el"))
(load custom-file)

(use-package emacs
  :delight (buffer-face-mode nil face-remap)
  :bind (([remap ispell-complete-word] . completion-at-point))
  :custom-face
  (default ((t (:family "Iosevka" :height 140))))
  (variable-pitch ((t (:family "Fira Sans" :height 116 :weight semi-light))))
  (fixed-pitch ((t (:family "Iosevka" :height 120))))
  (fixed-pitch-serif ((t (:family "Iosevka Etoile" :height 120)))))

(use-package solarized-theme
  :config
  (load-theme 'solarized-light)
  :custom
  (solarized-scale-org-headlines nil)
  (solarized-use-variable-pitch nil))

(use-package simple-modeline
  :hook (after-init . simple-modeline-mode)
  :custom
  (simple-modeline-segments
   '((simple-modeline-segment-modified
      simple-modeline-segment-buffer-name
      simple-modeline-segment-position)
     (simple-modeline-segment-minor-modes
      simple-modeline-segment-vc
      simple-modeline-segment-misc-info
      simple-modeline-segment-process
      simple-modeline-segment-major-mode)))
  :custom-face
  (simple-modeline-space ((t (:box nil)))))

(load (emacs-path "dot-org"))

(use-package simple
  :ensure nil
  :commands toggle-truncate-lines
  :hook ((org-mode . (lambda () (toggle-truncate-lines -1)))
         (markdown-mode . (lambda () (toggle-truncate-lines -1)))))

(use-package hl-line
  :hook (prog-mode . hl-line-mode))

(use-package undo-tree
  :delight
  :bind (("C-x u" . undo-tree-visualize)
         ("C-_" . undo-tree-undo)
         ("M-_" . undo-tree-redo))
  :hook (after-init . global-undo-tree-mode))

(use-package which-key
  :delight
  :hook (after-init . which-key-mode)
  :custom
  (which-key-min-display-lines 5)
  (which-key-popup-type 'minibuffer)
  (which-key-show-prefix 'bottom)
  (which-key-show-remaining-keys nil)
  (which-key-show-transient-maps t)
  (which-key-special-keys nil))

(use-package ace-window
  :bind (("C-x o" . ace-window)
         ("C-x C-o" . ace-swap-window)))

(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh"))

(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch))
  :custom
  (magit-diff-paint-whitespace nil)
  (magit-diff-refine-hunk t)
  (magit-diff-unmarked-lines-keep-foreground t))

(use-package ediff
  :commands (ediff-buffers ediff-buffers3)
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package autorevert
  :delight auto-revert-mode
  :commands auto-revert-mode)

(use-package eshell
  :commands eshell
  :bind (([remap eshell-pcomplete]   . completion-at-point))
  :custom
  (eshell-prompt-function 'epe-theme-multiline-with-status)
  (eshell-prefer-lisp-functions t)
  (eshell-cmpl-ignore-case t)
  :config
  (defun eshell-new()
    "Open a new instance of eshell."
    (interactive)
    (eshell 'N)))

(use-package eshell-prompt-extras
  :after eshell
  :commands (epe-theme-lambda  
             epe-theme-dakrone
             epe-theme-multiline-with-status)
  :custom-face
  (epe-pipeline-delimiter-face ((t (:inherit success))))
  (epe-pipeline-host-face ((t (:inherit escape-glyph))))
  (epe-pipeline-time-face ((t (:inherit warning))))
  (epe-pipeline-user-face ((t (:inherit error))))
  (epe-status-face ((t (:inherit font-lock-doc-face))))
  (epe-sudo-symbol-face ((t (:inherit eshell-ls-unreadable))))
  (epe-symbol-face ((t (:inherit eshell-ls-unreadable))))
  (epe-venv-face ((t (:inherit font-lock-comment-face))))
  (epe-git-dir-face ((t (:inherit font-lock-type-face)))))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-formats
   '((mark modified read-only locked
           " " (name 36 36 :left :elide)
           " " (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " " (name 16 -1)
           " " filename)))
  (ibuffer-elide-long-columns t)
  (ibuffer-expert t))

(use-package ibuffer-vc
  :after ibuffer
  :commands (ibuffer-vc-set-filter-groups-by-vc-root ibuffer-do-sort-by-alphabetic)
  :preface
  (defun my-ibuffer-vc-setup ()
    (ibuffer-vc-set-filter-groups-by-vc-root)
    (unless (eq ibuffer-sorting-mode 'alphabetic)
      (ibuffer-do-sort-by-alphabetic)))
  :hook (ibuffer . my-ibuffer-vc-setup))

(use-package project
  :ensure nil
  :functions project-root
  :bind-keymap (("C-c p" . project-prefix-map))
  :preface
  (defun project-magit-dir ()
    "Run `magit-status' in the current project's root."
    (interactive)
    (magit-status-setup-buffer (project-root (project-current t))))
  :custom
  (project-switch-commands
   '((project-find-file "Find file")
     (project-find-regexp "Find regexp")
     (project-dired "Dired")
     (project-magit-dir "Magit" ?m)
     (project-eshell "Eshell"))))

(use-package ag
  :commands ag)

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode)

(use-package restclient
  :mode ("\\.http\\'" . restclient-mode))

(use-package string-inflection
  :bind (("C-c C-u" . string-inflection-all-cycle)))

(use-package yasnippet
  :delight yas-minor-mode
  :hook (prog-mode . yas-minor-mode))

(use-package company
  :disabled
  :delight
  :hook (after-init . global-company-mode)
  :commands (company-complete)
  :bind ((:map company-mode-map
               ("C-M-i" . company-complete))
         ([remap completion-at-point]   . company-complete)
         ([remap ispell-complete-word]   . company-complete))
  :custom
  (company-minimum-prefix-length 3)
  (company-tooltip-align-annotations t)
  (company-tooltip-minimum-width 30)
  (company-idle-delay 0.5)
  (company-require-match nil)
  (company-backends '( company-files company-capf)))

(use-package flycheck
  :commands (flycheck-add-next-checker flycheck-get-next-checkers)
  :bind-keymap (("C-c f" . flycheck-command-map))
  :custom
  (flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list)
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-stylelintrc ".stylelintrc")
  (flycheck-temp-prefix "flycheck")
  :preface
  (defun gx-flycheck-add-next-checker (checker next)
    "Add NEXT checker after CHECKER if it's not already next."
    (unless (member next (flycheck-get-next-checkers checker))
      (flycheck-add-next-checker checker (cons t next))))
  
  (defun my-flycheck-setup ()
    "My flycheck setup."
    (interactive)
    (gx-flycheck-add-next-checker 'lsp 'javascript-eslint)
    (gx-flycheck-add-next-checker 'lsp 'scss-stylelint))
  :hook ((prog-mode . flycheck-mode)
         (lsp-after-initialize . my-flycheck-setup)))

(use-package flycheck-pos-tip
  :after flycheck
  :hook (flycheck-mode . flycheck-pos-tip-mode))

(use-package flycheck-indicator
  :after flycheck
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
  :delight
  :after flycheck-mode)

(use-package crux
  :bind (("C-a"     . crux-move-beginning-of-line)
	 ("C-M-l"   . crux-indent-defun)
	 ("C-c d"   . crux-duplicate-current-line-or-region)
	 ("C-x C-o" . crux-transpose-windows)))

(use-package move-text
  :bind (("C-S-n" . move-text-down)
         ("C-S-p" . move-text-up)))

(use-package expand-region
  :bind ("C-c w" . er/expand-region))

(use-package multiple-cursors
  :bind (("M-j"   . mc/mark-next-like-this-word)
         ("M-J"   . mc/unmark-next-like-this)
         ("C-c j n" . mc/insert-numbers))
  :config
  (add-to-list 'mc/cmds-to-run-once 'swiper-mc))

(use-package eldoc
  :delight
  :hook (prog-mode . eldoc-mode)
  :custom
  (eldoc-idle-delay 0.5))

(use-package rainbow-delimiters
  :hook ((lisp-mode emacs-lisp-mode) . rainbow-delimiters-mode))

(use-package elec-pair
  :hook (prog-mode . electric-pair-mode))

(use-package paren
  :hook (prog-mode . show-paren-mode))

(use-package ivy
  :hook (after-init . ivy-mode)
  :delight
  :bind ("C-x b" . ivy-switch-buffer)
  :custom
  (ivy-height 20)
  (ivy-use-virtual-buffers t)
  :custom-face
  (ivy-virtual ((t (:inherit font-lock-comment-face))))
  (ivy-org ((t (:inherit font-lock-doc-face)))))

(use-package ivy-rich
  :disabled
  :hook (ivy-mode . ivy-rich-mode)
  :custom
  (ivy-rich-parse-remote-buffer nil)
  (ivy-rich-display-transformers-list
   '(ivy-switch-buffer
     (:columns
      ((ivy-switch-buffer-transformer
        (:width 100))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 16 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
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

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package counsel
  :hook (after-init . counsel-mode)
  :delight
  :bind (("C-c i" . counsel-imenu))
  :bind (:map minibuffer-local-map
              ("M-r" . counsel-minibuffer-history))
  :custom
  (counsel-mode-override-describe-bindings t)
  (counsel-org-headline-display-priority nil))

(use-package counsel-ag-popup
  :after counsel
  :bind ("C-c s" . counsel-ag-popup))

(use-package lsp-mode
  :delight
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (((typescript-mode js2-mode scss-mode sh-mode) . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-auto-configure t)
  (lsp-auto-guess-root t)
  (lsp-flycheck-live-reporting t)
  (lsp-idle-delay 0.5)
  (lsp-imenu-show-container-name nil)
  (lsp-prefer-flymake nil)
  (lsp-signature-render-all nil)
  (lsp-symbol-highlighting-skip-current nil))

(use-package lisp-mode
  :ensure nil
  :commands (lisp-mode emacs-lisp-mode lisp-interaction-mode)
  :delight
  (lisp-mode "lisp")
  (emacs-lisp-mode "elisp")
  (lisp-interaction-mode "lisp-int")
  :preface
  (defun gx-compile-current-file ()
    "Compile current file."
    (interactive)
    (byte-compile-file (buffer-file-name)))
  :bind
  ("<f9>" . gx-compile-current-file))

(use-package powershell
  :mode ("\\.ps[dm]?1\\'" . powershell-mode))

(use-package js2-mode
  :delight "js2"
  :mode "\\.js\\'"
  :bind (:map js2-mode-map
              ("M-." . xref-find-definitions))
  :config
  (setq js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute"
                             "setTimeout" "clearTimeout" "setInterval" "clearInterval"
                             "location" "__dirname" "console" "JSON" "process"))
  :custom
  (js2-global-externs
    '("expect" "describe" "test" "beforeEach" "it" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "process"))
  (js2-highlight-external-variables nil)
  (js2-mode-show-parse-errors t)
  (js2-mode-show-strict-warnings t))

(use-package typescript-mode
  :delight "ts"
  :mode "\\.ts\\'"
  :custom
  (typescript-enabled-frameworks '(typescript))
  (typescript-flat-functions t))

(use-package add-node-modules-path
  :hook ((js2-mode typescript-mode) . add-node-modules-path))

(use-package mocha-snippets
  :after js2-mode
  :custom
  (mocha-snippets-string-delimiter "\""))

(use-package js2-refactor
  :delight
  :hook (js2-mode . js2-refactor-mode)
  :bind (:map js2-mode-map
              ("C-k" . js2r-kill))
  :commands js2r-add-keybindings-with-prefix
  :config
  (js2r-add-keybindings-with-prefix "C-c C-m")
  :custom
  (js2r-always-insert-parens-around-arrow-function-params t)
  (js2r-prefer-let-over-var t))

(use-package vue-mode
  :mode "\\.vue\\'")

(use-package json-mode
  :mode "\\.json\\'")

(use-package web-mode
  :mode "\\.html\\'"
  :commands web-mode-set-content-type
  :preface
  (defun my-web-mode-setup ()
    (if (equal web-mode-content-type "javascript")
        (web-mode-set-content-type "jsx")
      (message "now set to: %s" web-mode-content-type)))
  :hook (web-mode . my-web-mode-setup)
  :custom
  (web-mode-auto-close-style 1)
  (web-mode-enable-block-face nil)
  (web-mode-enable-css-colorization nil)
  (web-mode-enable-current-column-highlight nil)
  (web-mode-enable-current-element-highlight nil)
  (web-mode-enable-element-content-fontification nil)
  (web-mode-enable-element-tag-fontification nil)
  (web-mode-enable-engine-detection t)
  (web-mode-enable-html-entities-fontification t))

(use-package handlebars-mode
  :delight "hbs"
  :mode "\\.hbs\\'")

(use-package ob-http
  :after org-mode)

(use-package olivetti
  :commands olivetti-mode
  :custom
  (olivetti-body-width 100)
  (olivetti-minimum-body-width 70))

(use-package feature-mode
  :mode "\\.feature\\'")

(use-package markdown-mode
  :delight "md"
  :mode "\\.md\\'"
  :commands markdown-update-header-faces
  :custom
  (markdown-asymmetric-header nil)
  (markdown-command "pandoc")
  (markdown-hide-markup nil)
  (markdown-list-item-bullets '("•"))
  (markdown-marginalize-headers nil)
  (markdown-css-paths '("~/Projects/markdown-themes/markdownpad-github.css"))
  :custom-face
  (markdown-code-face ((t (:inherit (fixed-pitch highlight) :extend t))))
  (markdown-inline-code-face ((t (:inherit (fixed-pitch highlight))))))

(use-package graphviz-dot-mode
  :mode "\\.dot\\'")

(use-package cask-mode
  :mode "[Cc]ask\\'")

(use-package yaml-mode
  :mode "\\.yml\\'")

(use-package log-view
  :mode ("\\.log\\'" . log-view-mode))

(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package docker
  :commands docker-containers)

(use-package mermaid-mode
  :mode ("\\.mermaid\\'" . mermaid-mode))

(use-package stylus-mode
  :mode ("\\.styl\\'" . stylus-mode))

(use-package pug-mode
  :mode ("\\.pub\\'" . pug-mode)
  :custom
  (pug-tab-width 4))

(use-package csv-mode
  :mode ("\\.csv\\'" . csv-mode))

(use-package ssh-config-mode
  :mode (("/\\.ssh/config\\'" . ssh-config-mode)
         ("/sshd?_config\\'" . ssh-config-mode)
         ("/known_hosts\\'" . ssh-known-hosts-mode)
         ("/authorized_keys\\'" . ssh-authorized-keys-mode)))
