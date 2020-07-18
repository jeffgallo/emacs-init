

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(setq max-lisp-eval-depth 10000)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Import my Settings org-file:
(org-babel-load-file (expand-file-name "~/.emacs.d/settings.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(display-time-day-and-date t)
 '(display-time-default-load-average 0)
 '(display-time-load-average-threshold 0.1)
 '(display-time-mode t)
;; '(elfeed-feeds
;;   (quote
;;    ("www.slate.com/feeds/all.rss" "www.theverge.com/rss/index.xml")))
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/Nextcloud/org/Review.org" "~/Nextcloud/org/TODO.org" "~/Nextcloud/org/Journal.org" "~/Nextcloud/org/REFILE.org")))
 '(package-selected-packages
   (quote
    (elfeed-org elfeed company-tern company-tabnine company company-mode ac-js2 magit-popup php-mode rjsx-mode impatient-mode ac-emmet typescript-mode tern auto-complete evil-visual-mark-mode evil-indent-textobject evil-surround evil-leader helm helm-dash eslint-fix powerline-evil rw-ispell emmet-mode web-mode paredit flycheck-clojure flycheck-gradle flycheck-popup-tip flyparens helm-flycheck helm-flyspell rainbow-delimiters rainbow-mode paren-completer paren-face projectile cider clojure-mode helm-projectile helm-themes spotify which-key use-package ace-window mu4e-maildirs-extension evil-tutor flycheck flyspell-correct-helm)))
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values
   (quote
    ((org-download-image-dir . "~/Nextcloud/org/Journal-Images")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 2.5))))
 '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button))))))
