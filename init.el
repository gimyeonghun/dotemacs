(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(add-to-list 'load-path "~/.emacs.d/elpa")
(defalias 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)
(show-paren-mode 1)
(eldoc-mode 1)
(add-hook 'after-init-hook 'global-company-mode)

(require 'package)

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
             
(require 'evil)
(evil-mode 1)
(require 'org-journal)
(require 'undo-tree)
(global-undo-tree-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(require 'taskpaper-mode)
(add-to-list 'auto-mode-alist
             '("\\.todo\\'" . taskpaper-mode))

(defun applescript-quote-string (argument)
  "Quote a string for passing as a string to AppleScript."
  (if (or (not argument) (string-equal argument ""))
      "\"\""
    ;; Quote using double quotes, but escape any existing quotes or
    ;; backslashes in the argument with backslashes.
    (let ((result "")
          (start 0)
          end)
      (save-match-data
        (if (or (null (string-match "[^\"\\]" argument))
                (< (match-end 0) (length argument)))
            (while (string-match "[\"\\]" argument start)
              (setq end (match-beginning 0)
                    result (concat result (substring argument start end)
                                   "\\" (substring argument end (1+ end)))
                    start (1+ end))))
        (concat "\"" result (substring argument start) "\"")))))

(defun send-region-to-omnifocus (beg end)
  "Send the selected region to OmniFocus.
Use the first line of the region as the task name and the second
and subsequent lines as the task note."
  (interactive "r")
  (let* ((region (buffer-substring-no-properties beg end))
         (match (string-match "^\\(.*\\)$" region))
         (name (substring region (match-beginning 1) (match-end 1)))
         (note (if (< (match-end 0) (length region))
                   (concat (substring region (+ (match-end 0) 1) nil) "\n\n")
                 "")))
    (do-applescript
     (format "set theDate to current date
              set taskName to %s
              set taskNote to %s
              set taskNote to (taskNote) & \"Added from Emacs on \" & (theDate as string)
              tell front document of application \"OmniFocus\"
                make new inbox task with properties {name:(taskName), note:(taskNote)}
              end tell"
             (applescript-quote-string name)
             (applescript-quote-string note)))))

(global-set-key (kbd "C-c o") 'send-region-to-omnifocus)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (taskpaper-mode yasnippet-snippets yasnippet web-mode company ace-jump-mode tern use-package org-roam org-ref org-journal markdown-mode magit evil deft))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
