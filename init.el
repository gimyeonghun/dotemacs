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
  (setq journal-path "C:\\Users\\gim\\Documents\\journal"))

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

(use-package try
  :ensure t)

(use-package evil
  :config
  (evil-mode 1))

(use-package org-journal
  :ensure t
  :config
  (setq org-journal-dir journal-path))

(use-package undo-tree
  :commands global-undo-tree-mode)

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
  :defer t
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company yasnippet ivy evil-visual-mark-mode org-journal try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
