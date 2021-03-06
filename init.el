(menu-bar-mode -1)
(tool-bar-mode -1)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(setq auto-save-default nil)
(scroll-bar-mode -1)
(global-linum-mode 1)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(add-to-list 'load-path "~/.emacs.d/elpa")

(if (eq system-type 'darwin)
    (setq journal-path "~/Documents/journal")
  (setq journal-path "C:\\Users\\gim\\Documents\\journal")
  (add-to-list 'default-frame-alist '(font . "Consolas"))
  (set-face-attribute 'default t :font "Consolas"))

(defalias 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)
(show-paren-mode 1)
(eldoc-mode 1)
(add-hook 'after-init-hook 'global-company-mode)

(ido-mode t)
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (setq python-shell-interpreter "python3")
  (use-package flycheck
    :ensure t
    :init (global-flycheck-mode))
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-to-list 'flycheck-checkers 'textlint))

(use-package try
  :ensure t)

(use-package evil
  :config
  (evil-mode 1))

(use-package org-journal
  :ensure t
  :config
  (setq org-journal-dir journal-path)
  (setq org-journal-date-format "%A, %d %B %Y"))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package ivy
  :demand t
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.markdown\\'" . markdown-mode)
	 ("\\.md\\'" . markdown-mode)))

(use-package ace-jump-mode
  :ensure t
  :bind (:map evil-normal-state-map
	      ("SPC" . ace-jump-mode)))

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)))

(use-package yasnippet
  :demand t
  :config
  (yas-global-mode 1))

(use-package taskpaper-mode
  :mode (("\\.todo\\'" . taskpaper-mode)))

